using SGB.Shared;
using System.Xml.Linq;

namespace SGB.GameServer.Resources.Properties
{
    public sealed class XMLGround
    {
        public readonly int Type;
        public readonly string IdName;
        public readonly bool NoWalk;
        public readonly string DisplayId;
        public readonly int MinDamage;
        public readonly int MaxDamage;
        public readonly bool Sink;
        public readonly int Speed;
        public readonly bool Sinking;
        public readonly double XOffset;
        public readonly double YOffset;
        public readonly bool Push;
        public readonly double SlideAmount;

        public XMLGround(XElement elem)
        {
            Type = elem.IntAttribute("type");
            IdName = elem.StringAttribute("id");
            NoWalk = elem.BoolElement("NoWalk");
            DisplayId = elem.StringElement("id");
            MinDamage = elem.IntAttribute("MinDamage");
            MaxDamage = elem.IntAttribute("MaxDamage");
            Sink = elem.BoolElement("Sink");
            Speed = elem.IntAttribute("Speed");
            XOffset = elem.DoubleElement("XOffset");
            YOffset = elem.DoubleElement("YOffset");
            Push = elem.BoolElement("Push");
            SlideAmount = elem.DoubleElement("SlideAmount");
        }
    }
}
