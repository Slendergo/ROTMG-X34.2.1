namespace LocaleManager
{
    public sealed class LocaleParameter
    {
        public string Token { get; set; }
        public string Value { get; set; }
        public string LocaleType { get; set; }

        public LocaleParameter(string[] data)
        {
            Token = data[0];
            Value = data[1];
            LocaleType = data[2];
        }
    }
}