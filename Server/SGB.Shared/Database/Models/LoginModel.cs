namespace SGB.Shared.Database.Models
{
    public sealed class LoginModel
    {
        public const int LOGIN_MODEL_FAILURE = -1;

        public int AccountId { get; set; }
        public string Hash { get; set; }
        public bool IsBanned { get; set; }
    }
}
