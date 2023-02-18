using SGB.Shared.Database;
using System.Xml.Linq;

namespace SGB.API.Database.Models
{
    public static class XMLModelParser
    {
        public static XElement AccountModelToXML(AccountModel accountModel)
        {
            var elem = new XElement("Account");
            elem.Add(new XElement("AccountId", accountModel.AccountId));
            elem.Add(new XElement("Name", accountModel.Name));
            if (accountModel.NameChosen)
                elem.Add(new XElement("NameChosen"));
            if (accountModel.Converted)
                elem.Add(new XElement("Converted"));
            if (accountModel.Admin)
                elem.Add(new XElement("Admin"));
            if (accountModel.Mod)
                elem.Add(new XElement("Mod"));
            if (accountModel.IsAgeVerified)
                elem.Add(new XElement("IsAgeVerified", 1));
            //if (VerifiedEmail)
            elem.Add(new XElement("VerifiedEmail"));
            return elem;
        }
    }
}
