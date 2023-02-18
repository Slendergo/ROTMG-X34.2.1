using StackExchange.Redis;
using System.Text;

namespace SGB.Shared.Database
{
    public sealed class AccountModel : RedisObject
    {
        private static string ACCOUNT_NEXT_CHARACTER_ID = "nextCharId";
        private static string ACCOUNT_MAX_CHARACTER_SLOTS = "maxCharacterSlots";
        private static string ACCOUNT_NAME = "name";
        private static string ACCOUNT_NAME_CHOSEN = "nameChosen";
        private static string ACCOUNT_CONVERTED = "converted";
        private static string ACCOUNT_ADMIN = "admin";
        private static string ACCOUNT_MOD = "mod";
        private static string ACCOUNT_MAP_EDITOR = "mapEditor";
        private static string ACCOUNT_IS_AGE_VERIFIED = "isAgeVerified";
        private static string ACCOUNT_IS_EMAIL_VERIFIED = "isEmailVerified";

        public int AccountId { get; }
        public int NextCharId
        {
            get => GetValue<int>(ACCOUNT_NEXT_CHARACTER_ID);
            set => SetValue(ACCOUNT_NEXT_CHARACTER_ID, value);
        }
        public int MaxCharacterSlots
        {
            get => GetValue<int>(ACCOUNT_MAX_CHARACTER_SLOTS);
            set => SetValue(ACCOUNT_MAX_CHARACTER_SLOTS, value);
        }
        public string Name
        {
            get => GetValue<string>(ACCOUNT_NAME);
            set => SetValue(ACCOUNT_NAME, value);
        }
        public bool NameChosen
        {
            get => GetValue<bool>(ACCOUNT_NAME_CHOSEN);
            set => SetValue(ACCOUNT_NAME_CHOSEN, value);
        }
        public bool Converted
        {
            get => GetValue<bool>(ACCOUNT_CONVERTED);
            set => SetValue(ACCOUNT_CONVERTED, value);
        }
        public bool Admin
        {
            get => GetValue<bool>(ACCOUNT_ADMIN);
            set => SetValue(ACCOUNT_ADMIN, value);
        }
        public bool Mod
        {
            get => GetValue<bool>(ACCOUNT_MOD);
            set => SetValue(ACCOUNT_MOD, value);
        }
        public bool MapEditor
        {
            get => GetValue<bool>(ACCOUNT_MAP_EDITOR);
            set => SetValue(ACCOUNT_MAP_EDITOR, value);
        }
        public bool IsAgeVerified
        {
            get => GetValue<bool>(ACCOUNT_IS_AGE_VERIFIED);
            set => SetValue(ACCOUNT_IS_AGE_VERIFIED, value);
        }
        public bool VerifiedEmail
        {
            get => GetValue<bool>(ACCOUNT_IS_EMAIL_VERIFIED);
            set => SetValue(ACCOUNT_IS_EMAIL_VERIFIED, value);
        }

        public AccountModel(int accountId, IDatabase database) 
            : base($"account.{accountId}", database)
        {
            AccountId = accountId;
        }

        public override string ToString()
        {
            var sb = new StringBuilder("AccountModel { ");
            var properties = GetType().GetProperties();
            foreach (var property in properties)
            {
                sb.Append(property.Name);
                sb.Append(": ");
                sb.Append(property.GetValue(this));
                sb.Append(", ");
            }
            sb.Remove(sb.Length - 2, 2);
            sb.Append(" }");
            return sb.ToString();
        }
    }
}
