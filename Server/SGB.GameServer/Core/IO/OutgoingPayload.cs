using System;
using System.Buffers.Binary;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
using System.Text;
using static System.Runtime.InteropServices.JavaScript.JSType;

namespace SGB.GameServer.Core.IO
{
    public struct OutgoingPayload
    {
        public readonly byte Id;
        private byte[] Buffer;
        private int Position;

        public OutgoingPayload(byte id)
        {
            Id = id;
            Buffer = new byte[8];
            Position = 5;
        }

        public OutgoingPayload(byte id, int capacity)
        {
            Id = id;
            Buffer = new byte[capacity];
            Position = 5;
        }

        private void EnsureCapacity(int amount)
        {
            // mabye add some bounds checks
            // and other stuff?
            var bufferLength = Buffer.Length;
            if (Position + amount >= bufferLength)
                Array.Resize(ref Buffer, Math.Max(Buffer.Length * 2, Buffer.Length + amount));
        }

        public void WriteByte(int value)
        {
            EnsureCapacity(sizeof(byte));
            Buffer[Position] = (byte)value;
            Position += sizeof(byte);
        }

        public void WriteByte(byte value)
        {
            EnsureCapacity(sizeof(byte));
            Buffer[Position] = value;
            Position += sizeof(byte);
        }

        public void WriteBoolean(bool value)
        {
            EnsureCapacity(sizeof(byte));
            Buffer[Position] = (byte)(value ? 1 : 0);
            Position += sizeof(byte);
        }

        public void WriteFloat(float value) => WriteInt32(Unsafe.As<float, int>(ref value));

        public void WriteFloat(double val)
        {
            var value = (float)val;
            WriteInt32(Unsafe.As<float, int>(ref value));
        }

        public void WriteDouble(double value) => WriteInt64(Unsafe.As<double, long>(ref value));

        public void WriteDouble(float val)
        {
            var value = (double)val;
            WriteInt64(Unsafe.As<double, int>(ref value));
        }

        public void WriteInt16(short value)
        {
            EnsureCapacity(sizeof(short));
            if (BitConverter.IsLittleEndian)
                Unsafe.WriteUnaligned(ref Unsafe.Add(ref MemoryMarshal.GetArrayDataReference(Buffer), Position), value);
            else
                Unsafe.WriteUnaligned(ref Unsafe.Add(ref MemoryMarshal.GetArrayDataReference(Buffer), Position), BinaryPrimitives.ReverseEndianness(value));
            Position += sizeof(short);
        }

        public void WriteInt16(int value)
        {
            EnsureCapacity(sizeof(short));
            if (BitConverter.IsLittleEndian)
                Unsafe.WriteUnaligned(ref Unsafe.Add(ref MemoryMarshal.GetArrayDataReference(Buffer), Position), (short)value);
            else
                Unsafe.WriteUnaligned(ref Unsafe.Add(ref MemoryMarshal.GetArrayDataReference(Buffer), Position), BinaryPrimitives.ReverseEndianness((short)value));
            Position += sizeof(short);
        }

        public void WriteInt32(int value)
        {
            EnsureCapacity(sizeof(int));
            if (BitConverter.IsLittleEndian)
                Unsafe.WriteUnaligned(ref Unsafe.Add(ref MemoryMarshal.GetArrayDataReference(Buffer), Position), value);
            else
                Unsafe.WriteUnaligned(ref Unsafe.Add(ref MemoryMarshal.GetArrayDataReference(Buffer), Position), BinaryPrimitives.ReverseEndianness(value));
            Position += sizeof(int);
        }

        public void WriteInt64(long value)
        {
            EnsureCapacity(sizeof(long));
            if (BitConverter.IsLittleEndian)
                Unsafe.WriteUnaligned(ref Unsafe.Add(ref MemoryMarshal.GetArrayDataReference(Buffer), Position), value);
            else
                Unsafe.WriteUnaligned(ref Unsafe.Add(ref MemoryMarshal.GetArrayDataReference(Buffer), Position), BinaryPrimitives.ReverseEndianness(value));
            Position += sizeof(long);
        }

        public void WriteUTF16(string value)
        {
            var count = Encoding.UTF8.GetMaxByteCount(value.Length) + sizeof(short);
            EnsureCapacity(count);
            var length = Encoding.UTF8.GetBytes(value, Buffer.AsSpan(Position + sizeof(ushort)));
            WriteInt16((short)length);
            Position += length;
        }

        public void WriteUTF32(string value)
        {
            var count = Encoding.UTF8.GetMaxByteCount(value.Length) + sizeof(int);
            EnsureCapacity(count);
            var length = Encoding.UTF8.GetBytes(value, Buffer.AsSpan(Position + sizeof(uint)));
            WriteInt32(length);
            Position += length;
        }

        public void WriteBytes(byte[] value)
        {
            var len = value.Length;
            EnsureCapacity(len);
            Buffer.CopyTo(value.AsSpan(Position));
            Position += len;
        }

        public void WriteCompressedInt(int value)
        {
            var v = (uint)value;
            while (v >= 128)
            {
                WriteByte((byte)(v | 128));
                v >>= 7;
            }
            WriteByte((byte)v);
        }

        public Memory<byte> GetBuffer()
        {
            // 4 byte
            // 1 bytes
            // N bytes
            
            if (BitConverter.IsLittleEndian)
                Unsafe.WriteUnaligned(ref MemoryMarshal.GetArrayDataReference(Buffer), Buffer.Length);
            else
                Unsafe.WriteUnaligned(ref MemoryMarshal.GetArrayDataReference(Buffer), BinaryPrimitives.ReverseEndianness(Buffer.Length));
            Buffer[4] = Id;
            return Buffer;
        }
    }
}
