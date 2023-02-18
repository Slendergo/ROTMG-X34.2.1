using StackExchange.Redis;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.Json;

namespace SGB.Shared.Database
{
    public abstract class RedisObject
    {
        private readonly string Key;
        private Dictionary<RedisValue, KeyValuePair<byte[], bool>> Hashes;

        public RedisObject(string key, IDatabase database)
        {
            Key = key;
            Hashes = database.HashGetAll(Key).ToDictionary(_ => _.Name, _ => new KeyValuePair<byte[], bool>(_.Value, false));
        }

        protected T GetValue<T>(string key, T def = default)
        {
            if (!Hashes.TryGetValue(key, out var val) || val.Key == null)
                return def;

            switch (Type.GetTypeCode(typeof(T)))
            {
                case TypeCode.Int32:
                    return (T)(object)int.Parse(Encoding.UTF8.GetString(val.Key));
                case TypeCode.UInt32:
                    return (T)(object)uint.Parse(Encoding.UTF8.GetString(val.Key));
                case TypeCode.UInt16:
                    return (T)(object)ushort.Parse(Encoding.UTF8.GetString(val.Key));
                case TypeCode.Boolean:
                    return (T)(object)(val.Key[0] != 0);
                case TypeCode.DateTime:
                    return (T)(object)DateTime.FromBinary(BitConverter.ToInt64(val.Key, 0));
                case TypeCode.Object:
                    {
                        if (typeof(T) == typeof(byte[]))
                            return (T)(object)val.Key;

                        if (typeof(T) == typeof(ushort[]))
                        {
                            var ret = new ushort[val.Key.Length / 2];
                            Buffer.BlockCopy(val.Key, 0, ret, 0, val.Key.Length);
                            return (T)(object)ret;
                        }

                        if (typeof(T) == typeof(int[]) || typeof(T) == typeof(uint[]))
                        {
                            var ret = new int[val.Key.Length / 4];
                            Buffer.BlockCopy(val.Key, 0, ret, 0, val.Key.Length);
                            return (T)(object)ret;
                        }
                        throw new NotSupportedException();
                    }
                case TypeCode.String:
                    return (T)(object)Encoding.UTF8.GetString(val.Key);
                default:
                    throw new NotSupportedException();
            }
        }

        protected void SetValue<T>(string key, T val)
        {
            byte[] buff;
            switch (Type.GetTypeCode(typeof(T)))
            {
                case TypeCode.Int32:
                case TypeCode.UInt32:
                case TypeCode.UInt16:
                case TypeCode.String:
                    buff = Encoding.UTF8.GetBytes(val.ToString());
                    break;
                case TypeCode.Boolean:
                    buff = BitConverter.GetBytes((bool)(object)val);
                    break;
                case TypeCode.DateTime:
                    buff = BitConverter.GetBytes(((DateTime)(object)val).ToBinary());
                    break;
                case TypeCode.Byte:
                    buff = new byte[1] { (byte)(object)val };
                    break;
                case TypeCode.Int16:
                    buff = BitConverter.GetBytes((short)(object)val);
                    break;
                case TypeCode.Int64:
                    buff = BitConverter.GetBytes((long)(object)val);
                    break;
                case TypeCode.UInt64:
                    buff = BitConverter.GetBytes((ulong)(object)val);
                    break;
                case TypeCode.Single:
                    buff = BitConverter.GetBytes((float)(object)val);
                    break;
                case TypeCode.Double:
                    buff = BitConverter.GetBytes((double)(object)val);
                    break;
                case TypeCode.Object:
                    if (typeof(T) == typeof(byte[]))
                        buff = (byte[])(object)val;
                    else if (typeof(T) == typeof(ushort[]))
                    {
                        var v = (ushort[])(object)val;
                        buff = new byte[v.Length * sizeof(short)];
                        Buffer.BlockCopy(v, 0, buff, 0, buff.Length);
                    }
                    else if (typeof(T) == typeof(int[]) || typeof(T) == typeof(uint[]))
                    {
                        var v = (int[])(object)val;
                        buff = new byte[v.Length * sizeof(int)];
                        Buffer.BlockCopy(v, 0, buff, 0, buff.Length);
                    }
                    else
                        throw new NotSupportedException();
                    break;
                default:
                    throw new NotSupportedException();
            }

            if (!Hashes.ContainsKey(Key) || Hashes[Key].Key == null || !buff.SequenceEqual(Hashes[Key].Key))
                Hashes[key] = new KeyValuePair<byte[], bool>(buff, true);
        }
    }

    public static class RedisDB
    {
        public static ConnectionMultiplexer ConnectionMultiplexer { get; private set; }
        public static IDatabase Database { get; private set; }

        public static bool Configure(string connectionString, int databaseIndex)
        {
            try
            {
                ConnectionMultiplexer = ConnectionMultiplexer.Connect(connectionString, options =>
                {
                    // incase options are needed
                    //options.Password = "password";
                });

                Database = ConnectionMultiplexer.GetDatabase(databaseIndex);
            }
            catch (Exception ex)
            {
                return false;
            }
            return true;
        }

        public static int IsValidLogin(string guid, string password)
        {
            var guidLow = guid.ToLower();
            if (!Database.HashExists("logins", guidLow))
                return LoginModel.LOGIN_MODEL_FAILURE;
            var json = Database.HashGet("logins", guidLow);
            var login = JsonSerializer.Deserialize<LoginModel>(json);
            return login.Hash == Hashing.GetHashedPassword(password) ? login.AccountId : LoginModel.LOGIN_MODEL_FAILURE;
        }

        public static AccountModel GetAccountModel(int accountId)
        {
            if (Database.KeyExists($"account.{accountId}"))
                return new AccountModel(accountId, Database);
            return null;
        }
    }
}
