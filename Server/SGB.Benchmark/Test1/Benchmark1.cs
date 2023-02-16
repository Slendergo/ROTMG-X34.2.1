
using BenchmarkDotNet.Attributes;

namespace SGB.Benchmark.Tests
{
    [MemoryDiagnoser]
    [SimpleJob(warmupCount: 512)]
    public class Benchmark1
    {
        public IncomingPayload Struct;

        [Params(1, 10, 100, 1000, 10000)]
        public int Size;

        [GlobalSetup]
        public void Setup()
        {
            var buffer = new byte[ushort.MaxValue];
            Array.Fill(buffer, (byte)Random.Shared.Next(byte.MinValue, byte.MaxValue));
            Struct = new IncomingPayload(buffer, 4);
        }

        [Benchmark]
        public byte ReadByte() => Struct.ReadByte();

        //[Benchmark]
        //public bool ReadBoolean() => Struct.ReadBoolean();

        //[Benchmark]
        //public short ReadInt16() => Struct.ReadInt16();

        //[Benchmark]
        //public int ReadInt32() => Struct.ReadInt32();

        //[Benchmark]
        //public long ReadInt64() => Struct.ReadInt64();

        //[Benchmark]
        //public byte[] ReadBytes() => Struct.ReadBytes(Size);

        //[Benchmark]
        //public float ReadFloat() => Struct.ReadFloat();

        //[Benchmark]
        //public double ReadDouble() => Struct.ReadFloat();

        //[Benchmark]
        //public string ReadUTF16() => Struct.ReadUTF16();

        //[Benchmark]
        //public string ReadUTF32() => Struct.ReadUTF32();
    }
}
