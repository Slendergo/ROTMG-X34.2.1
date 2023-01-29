using System.Xml.Linq;

namespace SGB.API.Database.Models
{
    public sealed class AccountModel
    {
        public int AccountId { get; set; }
        public int NextCharId { get; set; }
        public int MaxCharacterSlots { get; set; }
        public string Name { get; set; }
        public bool NameChosen { get; set; }
        public bool Converted { get; set; }
        public bool Admin { get; set; }
        public bool Mod { get; set; }
        public bool MapEditor { get; set; }
        public bool IsAgeVerified { get; set; }
        public bool VerifiedEmail { get; set; }

        public XElement AsXML()
        {
            var elem = new XElement("Account");
            elem.Add(new XElement("AccountId", AccountId));
            elem.Add(new XElement("Name", Name));
            if (NameChosen)
                elem.Add(new XElement("NameChosen"));
            if (Converted)
                elem.Add(new XElement("Converted"));
            if (Admin)
                elem.Add(new XElement("Admin"));
            if (Mod)
                elem.Add(new XElement("Mod"));
            if (IsAgeVerified)
                elem.Add(new XElement("IsAgeVerified", 1));
            //if (VerifiedEmail)
                elem.Add(new XElement("VerifiedEmail"));
            return elem;
        }
    }
}
