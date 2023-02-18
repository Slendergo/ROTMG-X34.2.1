using System;
using System.ComponentModel;
using System.Globalization;
using System.Linq;
using System.Xml.Linq;

namespace SGB.Shared
{
    // todo remake this and make it more user friendly
    public static class XElementUtils
    {
        public static bool HasAttribute(this XElement elem, string name) => elem.Attribute(name) != null;
        public static bool HasElement(this XElement elem, string name) => elem.Element(name) != null;

        public static byte ByteAttribute(this XElement elem, string name, byte def = 0)
        {
            var val = elem.Attribute(name)?.Value;
            var isHex = val != null && val.Contains("0x");
            var isNegative = val != null && val.Contains('-');
            if (isNegative)
            {
                var format = new NumberFormatInfo { NegativeSign = "-" };
                return val == null ? def : byte.Parse(val, format);
            }
            return val == null ? def : byte.Parse(isHex ? val[2..] : val, isHex ? NumberStyles.HexNumber : NumberStyles.None);
        }


        public static byte ByteElement(this XElement elem, string name, byte def = 0)
        {
            var val = elem.Element(name)?.Value;
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


        public static string StringAttribute(this XElement elem, string name, string def = "") => elem.Attribute(name)?.Value ?? def;
        public static string StringElement(this XElement elem, string name, string def = "") => elem.Element(name)?.Value ?? def;

        public static int IntAttribute(this XElement elem, string name, int def = 0)
        {
            var val = elem.Attribute(name)?.Value;
            var isHex = val != null && val.Contains("0x");
            var isNegative = val != null && val.Contains('-');
            if (isNegative)
            {
                var format = new NumberFormatInfo { NegativeSign = "-" };
                return val == null ? def : int.Parse(val, format);
            }
            return val == null ? def : int.Parse(isHex ? val[2..] : val, isHex ? NumberStyles.HexNumber : NumberStyles.None);
        }

        public static short ShortAttribute(this XElement elem, string name, short def = 0)
        {
            var val = elem.Attribute(name)?.Value;
            var isHex = val != null && val.Contains("0x");
            var isNegative = val != null && val.Contains('-');
            if (isNegative)
            {
                var format = new NumberFormatInfo { NegativeSign = "-" };
                return val == null ? def : short.Parse(val, format);
            }
            return val == null ? def : short.Parse(isHex ? val[2..] : val, isHex ? NumberStyles.HexNumber : NumberStyles.None);
        }

        public static short ShortElement(this XElement elem, string name, short def = 0)
        {
            var val = elem.Element(name)?.Value;
            var isHex = val != null && val.Contains("0x");
            var isNegative = val != null && val.Contains('-');
            if (isNegative)
            {
                var format = new NumberFormatInfo() { NegativeSign = "-" };
                return val == null ? def : short.Parse(val, format);
            }
            return val == null ? def : short.Parse(isHex ? val[2..] : val, isHex ? NumberStyles.HexNumber : NumberStyles.None);
        }

        public static int IntElement(this XElement elem, string name, int def = 0)
        {
            var val = elem.Element(name)?.Value;
            var isHex = val != null && val.Contains("0x");
            var isNegative = val != null && val.Contains("-");
            if (isNegative)
            {
                var format = new NumberFormatInfo() { NegativeSign = "-" };
                return val == null ? def : int.Parse(val, format);
            }
            return val == null ? def : int.Parse(isHex ? val[2..] : val, isHex ? NumberStyles.HexNumber : NumberStyles.None);
        }

        public static bool BoolAttribute(this XElement elem, string name, bool def = false)
        {
            var e = elem.Attribute(name);
            if (e == null)
                return def;
            return e.Value != "0" && e.Value.ToLower() != "false";
        }

        public static bool BoolElement(this XElement elem, string name, bool def = false)
        {
            var e = elem.Element(name);
            if (e == null)
                return def;
            return e.Value != "0" && e.Value.ToLower() != "false";
        }

        public static byte[] FromCommaSepString8(this XElement elem, string name)
        {
            var e = elem.Element(name);
            if (e == null)
                return Array.Empty<byte>();
            return ArrayUtils.FromCommaSepString8(e.Value);
        }

        public static short[] FromCommaSepString16(this XElement elem, string name)
        {
            var e = elem.Element(name);
            if (e == null)
                return Array.Empty<short>();
            return ArrayUtils.FromCommaSepString16(e.Value);
        }

        public static int[] FromCommaSepString32(this XElement elem, string name)
        {
            var e = elem.Element(name);
            if (e == null)
                return Array.Empty<int>();
            return ArrayUtils.FromCommaSepString32(e.Value);
        }

        public static long[] FromCommaSepString64(this XElement elem, string name)
        {
            var e = elem.Element(name);
            if (e == null)
                return Array.Empty<long>();
            return ArrayUtils.FromCommaSepString64(e.Value);
        }

        public static sbyte[] FromCommaSepStringS8(this XElement elem, string name)
        {
            var e = elem.Element(name);
            if (e == null)
                return Array.Empty<sbyte>();
            return ArrayUtils.FromCommaSepStringU8(e.Value);
        }

        public static ushort[] FromCommaSepStringU16(this XElement elem, string name)
        {
            var e = elem.Element(name);
            if (e == null)
                return Array.Empty<ushort>();
            return ArrayUtils.FromCommaSepStringU16(e.Value);
        }

        public static uint[] FromCommaSepStringU32(this XElement elem, string name)
        {
            var e = elem.Element(name);
            if (e == null)
                return Array.Empty<uint>();
            return ArrayUtils.FromCommaSepStringU32(e.Value);
        }

        public static ulong[] FromCommaSepStringU64(this XElement elem, string name)
        {
            var e = elem.Element(name);
            if (e == null)
                return Array.Empty<ulong>();
            return ArrayUtils.FromCommaSepStringU64(e.Value);
        }

        public static double DoubleAttribute(this XElement elem, string name, double def = 0.0) => elem.Attribute(name) == null ? def : double.Parse(elem.Attribute(name).Value);
        public static double DoubleElement(this XElement elem, string name, double def = 0.0) => elem.Element(name) == null ? def : double.Parse(elem.Element(name).Value);
        public static float FloatAttribute(this XElement elem, string name, float def = 0.0f) => elem.Attribute(name) == null ? def : float.Parse(elem.Attribute(name).Value);
        public static float FloatElement(this XElement elem, string name, float def = 0.0f) => elem.Element(name) == null ? def : float.Parse(elem.Element(name).Value);
    }
}
