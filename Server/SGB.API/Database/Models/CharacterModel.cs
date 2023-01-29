using System;
using System.Xml.Linq;

namespace SGB.API.Database.Models
{
    public sealed class CharacterModel
    {
        public int CharacterId { get; set; }
        public int ObjectType { get; set; }
        public int Level { get; set; }
        public int Exp { get; set; }
        public string Equipment { get; set; }
        public int MaxHitPoints { get; set; }
        public int HitPoints { get; set; }
        public int MaxMagicPoints { get; set; }
        public int MagicPoints { get; set; }
        public int Attack { get; set; }
        public int Defense { get; set; }
        public int Speed { get; set; }
        public int Dexterity { get; set; }
        public int HpRegen { get; set; }
        public int MpRegen { get; set; }
        public int Texture { get; set; }
        public int Tex1 { get; set; }
        public int Tex2 { get; set; }
        public int CurrentFame { get; set; }
        public bool HasBackpack { get; set; }
        public DateTime CreationDate { get; set; }
        public int PetId { get; set; }

        public XElement AsXML()
        {
            var elem = new XElement("Char");
            elem.Add(new XAttribute("id", CharacterId));
            elem.Add(new XElement("ObjectType", ObjectType));
            elem.Add(new XElement("Level", Level));
            elem.Add(new XElement("Exp", Exp));
            elem.Add(new XElement("CurrentFame", CurrentFame));
            elem.Add(new XElement("MaxHitPoints", MaxHitPoints));
            elem.Add(new XElement("HitPoints", HitPoints));
            elem.Add(new XElement("MaxMagicPoints", MaxMagicPoints));
            elem.Add(new XElement("MagicPoints", MagicPoints));
            elem.Add(new XElement("Attack", Attack));
            elem.Add(new XElement("Defense", Defense));
            elem.Add(new XElement("Speed", Speed));
            elem.Add(new XElement("Dexterity", Dexterity));
            elem.Add(new XElement("HpRegen", HpRegen));
            elem.Add(new XElement("MpRegen", MpRegen));
            elem.Add(new XElement("Texture", Texture));
            elem.Add(new XElement("Tex1", Tex1));
            elem.Add(new XElement("Tex2", Tex2));
            if (HasBackpack)
                elem.Add(new XElement("HasBackpack", 1));
            elem.Add(new XElement("CreationDate", CreationDate));
            return elem;
        }
    }
}