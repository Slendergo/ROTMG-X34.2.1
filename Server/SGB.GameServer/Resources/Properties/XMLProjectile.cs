using SGB.Shared;
using System.Linq;
using System.Xml.Linq;

namespace SGB.GameServer.Resources.Properties
{
    public sealed class XMLProjectile
    {
        public readonly int Id;
        public readonly string ObjectId;
        public readonly int Damage;
        public readonly double Speed;
        public readonly double LifetimeMS;
        public readonly bool ArmorPiercing;
        public readonly bool MultiHit;
        public readonly int Size;
        public readonly XMLConditionEffect[] ConditionEffects;
        public readonly double Amplitude;
        public readonly double Frequency;
        public readonly bool FaceDir;
        public readonly int MinDamage;
        public readonly int MaxDamage;
        public readonly bool PassesCover;
        public readonly bool Boomerang;
        public readonly bool Magnitude;
        public readonly bool ParticleTrail;
        public readonly bool Parametric;
        public readonly bool Wavy;

        public XMLProjectile(XElement elem)
        {
            Id = elem.IntAttribute("id");
            ObjectId = elem.StringElement("ObjectId");
            Damage = elem.IntElement("Damage");
            Speed = elem.DoubleElement("Speed");
            LifetimeMS = elem.DoubleElement("LifetimeMS");
            ArmorPiercing = elem.BoolElement("ArmorPiercing");
            MultiHit = elem.BoolElement("MultiHit");
            Size = elem.IntElement("Size");
            ConditionEffects = elem.Elements().Select(_ => new XMLConditionEffect(elem)).ToArray();
            Amplitude = elem.DoubleElement("Amplitude");
            Frequency = elem.DoubleElement("Frequency");
            FaceDir = elem.BoolElement("FaceDir");
            MinDamage = elem.IntElement("MinDamage");
            MaxDamage = elem.IntElement("MaxDamage");
            PassesCover = elem.BoolElement("PassesCover");
            Boomerang = elem.BoolElement("Boomerang");
            Magnitude = elem.BoolElement("Magnitude");
            ParticleTrail = elem.BoolElement("ParticleTrail");
            Parametric = elem.BoolElement("Parametric");
            Wavy = elem.BoolElement("Wavy");
        }
    }
}
