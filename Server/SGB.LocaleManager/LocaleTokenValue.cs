namespace LocaleManager
{
    public sealed class LocaleTokenValue
    {
        public string Token { get; set; }
        public string Value { get; set; }

        public LocaleTokenValue(string token, string value)
        {
            Token = token;
            Value = value;
        }

        public override string ToString() => $"'{Token}' = '{Value}'";
    }
}