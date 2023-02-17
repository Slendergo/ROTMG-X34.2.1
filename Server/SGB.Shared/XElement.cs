using System.Globalization;
using System.Xml.Linq;

namespace SGB.Shared
{
    // todo remake this and make it faster and or more user friendly
    public static class XElementExtensions
    {
        public static bool HasAttribute(this XElement elem, string value) => elem.Attribute(value) != null;
        public static bool HasElement(this XElement elem, string value) => elem.Element(value) != null;

        public static byte ByteAttribute(this XElement elem, string value, byte def = 0)
        {
            var val = elem.Attribute(value)?.Value;
            var isHex = val != null && val.Contains("0x");
            var isNegative = val != null && val.Contains('-');
            if (isNegative)
            {
                var format = new NumberFormatInfo { NegativeSign = "-" };
                return val == null ? def : byte.Parse(val, format);
            }
            return val == null ? def : byte.Parse(isHex ? val[2..] : val, isHex ? NumberStyles.HexNumber : NumberStyles.None);
        }


        public static byte ByteElement(this XElement elem, string value, byte def = 0)
        {
            var val = elem.Element(value)?.Value;
            var isHex = val != null && val.Contains("0x");
            var isNegative = val != null && val.Contains('-');
            if (isNegative)
            {
                var format = new NumberFormatInfo { NegativeSign = "-" };
                return val == null ? def : byte.Parse(val, format);
            }
            return val == null ? def : byte.Parse(isHex ? val[2..] : val, isHex ? NumberStyles.HexNumber : NumberStyles.None);
        }


        public static int IntValue(this XElement elem)
        {
            var val = elem.Value;
            var isHex = val != null && val.Contains("0x");
            return int.Parse(isHex ? val[2..] : val, isHex ? NumberStyles.HexNumber : NumberStyles.None);
        }


        public static string StringAttribute(this XElement elem, string value, string def = "") => elem.Attribute(value)?.Value ?? def;
        public static string StringElement(this XElement elem, string value, string def = "") => elem.Element(value)?.Value ?? def;

        public static int IntAttribute(this XElement elem, string value, int def = 0)
        {
            var val = elem.Attribute(value)?.Value;
            var isHex = val != null && val.Contains("0x");
            var isNegative = val != null && val.Contains('-');
            if (isNegative)
            {
                var format = new NumberFormatInfo { NegativeSign = "-" };
                return val == null ? def : int.Parse(val, format);
            }
            return val == null ? def : int.Parse(isHex ? val[2..] : val, isHex ? NumberStyles.HexNumber : NumberStyles.None);
        }

        public static short ShortAttribute(this XElement elem, string value, short def = 0)
        {
            var val = elem.Attribute(value)?.Value;
            var isHex = val != null && val.Contains("0x");
            var isNegative = val != null && val.Contains('-');
            if (isNegative)
            {
                var format = new NumberFormatInfo { NegativeSign = "-" };
                return val == null ? def : short.Parse(val, format);
            }
            return val == null ? def : short.Parse(isHex ? val[2..] : val, isHex ? NumberStyles.HexNumber : NumberStyles.None);
        }

        public static short ShortElement(this XElement elem, string value, short def = 0)
        {
            var val = elem.Element(value)?.Value;
            var isHex = val != null && val.Contains("0x");
            var isNegative = val != null && val.Contains('-');
            if (isNegative)
            {
                var format = new NumberFormatInfo() { NegativeSign = "-" };
                return val == null ? def : short.Parse(val, format);
            }
            return val == null ? def : short.Parse(isHex ? val[2..] : val, isHex ? NumberStyles.HexNumber : NumberStyles.None);
        }

        public static int IntElement(this XElement elem, string value, int def = 0)
        {
            var val = elem.Element(value)?.Value;
            var isHex = val != null && val.Contains("0x");
            var isNegative = val != null && val.Contains("-");
            if (isNegative)
            {
                var format = new NumberFormatInfo() { NegativeSign = "-" };
                return val == null ? def : int.Parse(val, format);
            }
            return val == null ? def : int.Parse(isHex ? val[2..] : val, isHex ? NumberStyles.HexNumber : NumberStyles.None);
        }

        public static bool BoolAttribute(this XElement elem, string value, bool def = false)
        {
            var o = elem.Attribute(value);
            if (o == null)
                return def;
            return o.Value != "0" && o.Value.ToLower() != "false";
        }

        public static bool BoolElement(this XElement elem, string value, bool def = false)
        {
            var o = elem.Element(value);
            if (o == null)
                return def;
            return o.Value != "0" && o.Value.ToLower() != "false";
        }

        public static double DoubleAttribute(this XElement elem, string value, double def = 0.0) => elem.Attribute(value) == null ? def : double.Parse(elem.Attribute(value).Value);
        public static double DoubleElement(this XElement elem, string value, double def = 0.0) => elem.Element(value) == null ? def : double.Parse(elem.Element(value).Value);
        public static float FloatAttribute(this XElement elem, string value, float def = 0.0f) => elem.Attribute(value) == null ? def : float.Parse(elem.Attribute(value).Value);
        public static float FloatElement(this XElement elem, string value, float def = 0.0f) => elem.Element(value) == null ? def : float.Parse(elem.Element(value).Value);
    }
}
