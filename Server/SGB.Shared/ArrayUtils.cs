using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;

namespace SGB.Shared
{
    public static class ArrayUtils
    {
        public static byte[] FromCommaSepString8(string value) => string.IsNullOrEmpty(value) ? Array.Empty<byte>() : value?.Split(',').Select(_ => _.Contains("0x") ? byte.Parse(_.Trim().Substring(2), NumberStyles.HexNumber) : byte.Parse(_.Trim())).ToArray();
        public static short[] FromCommaSepString16(string value) => string.IsNullOrEmpty(value) ? Array.Empty<short>() : value?.Split(',').Select(_ => _.Contains("0x") ? short.Parse(_.Trim().Substring(2), NumberStyles.HexNumber) : short.Parse(_.Trim())).ToArray();
        public static long[] FromCommaSepString64(string value) => string.IsNullOrEmpty(value) ? Array.Empty<long>() : value?.Split(',').Select(_ => _.Contains("0x") ? long.Parse(_.Trim().Substring(2), NumberStyles.HexNumber) : long.Parse(_.Trim())).ToArray();
        public static int[] FromCommaSepString32(string value) => string.IsNullOrEmpty(value) ? Array.Empty<int>() : value?.Split(',').Select(_ => _.Contains("0x") ? int.Parse(_.Trim().Substring(2), NumberStyles.HexNumber) : int.Parse(_.Trim())).ToArray();

        public static sbyte[] FromCommaSepStringU8(string value) => string.IsNullOrEmpty(value) ? Array.Empty<sbyte>() : value?.Split(',').Select(_ => _.Contains("0x") ? sbyte.Parse(_.Trim().Substring(2), NumberStyles.HexNumber) : sbyte.Parse(_.Trim())).ToArray();
        public static ushort[] FromCommaSepStringU16(string value) => string.IsNullOrEmpty(value) ? Array.Empty<ushort>() : value?.Split(',').Select(_ => _.Contains("0x") ? ushort.Parse(_.Trim().Substring(2), NumberStyles.HexNumber) : ushort.Parse(_.Trim())).ToArray();
        public static uint[] FromCommaSepStringU32(string value) => string.IsNullOrEmpty(value) ? Array.Empty<uint>() : value?.Split(',').Select(_ => _.Contains("0x") ? uint.Parse(_.Trim().Substring(2), NumberStyles.HexNumber) : uint.Parse(_.Trim())).ToArray();
        public static ulong[] FromCommaSepStringU64(string value) => string.IsNullOrEmpty(value) ? Array.Empty<ulong>() : value?.Split(',').Select(_ => _.Contains("0x") ? ulong.Parse(_.Trim().Substring(2), NumberStyles.HexNumber) : ulong.Parse(_.Trim())).ToArray();

        public static string ToCommaSepString<T>(T[] arr) => string.Join(",", arr.Select(_ => _.ToString()));
        public static string ToCommaSepString<T>(IList<T> arr) => string.Join(",", arr.Select(_ => _.ToString()));
    }
}