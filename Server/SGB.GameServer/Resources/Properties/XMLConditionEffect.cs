using SGB.Shared;
using System.Xml.Linq;

namespace SGB.GameServer.Resources.Properties
{
    public sealed class XMLConditionEffect
    {
        public readonly string Effect;
        public readonly double Duration;

        public XMLConditionEffect(string effect, double duration)
        {
            Effect = effect;
            Duration = duration;
        }

        public XMLConditionEffect(XElement elem)
        {
            Effect = elem.Value;
            Duration = elem.DoubleAttribute("duration");
        }
    }
}
