using SGB.Shared.Database.Models;
using System.Reflection.Emit;
using System.Xml.Linq;
using static System.Net.Mime.MediaTypeNames;

namespace SGB.API.Database
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

        public static XElement CharacterModelToXML(CharacterModel characterModel)
        {
            var elem = new XElement("Char");
            elem.Add(new XAttribute("id", characterModel.CharacterId));
            elem.Add(new XElement("ObjectType", characterModel.ObjectType));
            elem.Add(new XElement("Level", characterModel.Level));
            elem.Add(new XElement("Exp", characterModel.Experience));
            elem.Add(new XElement("CurrentFame", characterModel.CurrentFame));
            elem.Add(new XElement("MaxHitPoints", characterModel.MaxHitPoints));
            elem.Add(new XElement("HitPoints", characterModel.HitPoints));
            elem.Add(new XElement("MaxMagicPoints", characterModel.MaxMagicPoints));
            elem.Add(new XElement("MagicPoints", characterModel.MagicPoints));
            elem.Add(new XElement("Attack", characterModel.Attack));
            elem.Add(new XElement("Defense", characterModel.Defense));
            elem.Add(new XElement("Speed", characterModel.Speed));
            elem.Add(new XElement("Dexterity", characterModel.Dexterity));
            elem.Add(new XElement("HpRegen", characterModel.HpRegen));
            elem.Add(new XElement("MpRegen", characterModel.MpRegen));
            elem.Add(new XElement("Texture", characterModel.Texture));
            elem.Add(new XElement("Tex1", characterModel.Tex1));
            elem.Add(new XElement("Tex2", characterModel.Tex2));
            if (characterModel.HasBackpack)
                elem.Add(new XElement("HasBackpack", 1));
            elem.Add(new XElement("CreationDate", characterModel.CreationDate));
            return elem;
        }
    }
}
