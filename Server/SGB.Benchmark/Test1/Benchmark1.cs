
using BenchmarkDotNet.Attributes;
using System.Globalization;
using System.Xml.Linq;
using SGB.Shared;

namespace SGB.Benchmark.Tests
{
    [MemoryDiagnoser]
    public class Benchmark1
    {
        public XElement Element = new XElement("Player", new XElement("Equipment", "0xa1a, 0xa61, -1, -1, 0xa22, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1"));

        [Benchmark]
        public void StandardPserverFromCommaSepString32()
        {
            _ = Element.OtherFromComSepString32("Equipment");
        }

        [Benchmark]
        public void FromCommaSepString8()
        {
            _ = Element.FromCommaSepString32("Equipment");
        }

        [Benchmark]
        public void FromCommaSepString16()
        {
            _ = Element.FromCommaSepString16("Equipment");
        }

        [Benchmark]
        public void FromCommaSepString32()
        {
            _ = Element.FromCommaSepString32("Equipment");
        }

        [Benchmark]
        public void FromCommaSepString64()
        {
            _ = Element.FromCommaSepString64("Equipment");
        }
    }

    public static class Standard
    {
        public static int[] OtherFromComSepString32(this XElement elem, string value)
        {
            var e = elem.Element(value);
            if (e == null)
                return null;
            if (IsNullOrWhiteSpace(e.Value)) return new int[0];
            return e.Value.Split(',').Select(_ => FromString(_.Trim())).ToArray();
        }

        public static bool IsNullOrWhiteSpace(this string value)
        {
            if (value == null)
                return true;

            var index = 0;
            while (index < value.Length)
            {
                if (char.IsWhiteSpace(value[index]))
                    index++;
                else
                    return false;
            }
            return true;
        }

        public static int FromString(string x)
        {
            x = x.Trim();
            if (x.StartsWith("0x")) return int.Parse(x.Substring(2), NumberStyles.HexNumber);
            return int.Parse(x);
        }
    }
}
