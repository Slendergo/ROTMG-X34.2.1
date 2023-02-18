using SGB.GameServer.Core.Database;
using SGB.GameServer.Core.Game;
using SGB.GameServer.Utils;
using SGB.Shared;
using System;
using System.Collections.Generic;
using System.Net.Sockets;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
using System.Text;

namespace SGB.GameServer.Core.IO
{
    public static class IOHelper
    {
        public const int FAILURE = 0;
        public const int CREATE_SUCCESS = 101;
        public const int CREATE = 61;
        public const int PLAYERSHOOT = 30;
        public const int MOVE = 42;
        public const int PLAYERTEXT = 10;
        public const int TEXT = 44;
        public const int SERVERPLAYERSHOOT = 12;
        public const int DAMAGE = 75;
        public const int UPDATE = 62;
        public const int UPDATEACK = 81;
        public const int NOTIFICATION = 67;
        public const int NEWTICK = 9;
        public const int INVSWAP = 19;
        public const int USEITEM = 11;
        public const int SHOWEFFECT = 13;
        public const int HELLO = 1;
        public const int GOTO = 18;
        public const int INVDROP = 55;
        public const int INVRESULT = 95;
        public const int RECONNECT = 45;
        public const int PING = 8;
        public const int PONG = 31;
        public const int MAPINFO = 92;
        public const int LOAD = 57;
        public const int PIC = 83;
        public const int SETCONDITION = 60;
        public const int TELEPORT = 74;
        public const int USEPORTAL = 47;
        public const int DEATH = 46;
        public const int BUY = 85;
        public const int BUYRESULT = 22;
        public const int AOE = 64;
        public const int GROUNDDAMAGE = 103;
        public const int PLAYERHIT = 90;
        public const int ENEMYHIT = 25;
        public const int AOEACK = 89;
        public const int SHOOTACK = 100;
        public const int OTHERHIT = 20;
        public const int SQUAREHIT = 40;
        public const int GOTOACK = 65;
        public const int EDITACCOUNTLIST = 27;
        public const int ACCOUNTLIST = 99;
        public const int QUESTOBJID = 82;
        public const int CHOOSENAME = 97;
        public const int NAMERESULT = 21;
        public const int CREATEGUILD = 59;
        public const int GUILDRESULT = 26;
        public const int GUILDREMOVE = 15;
        public const int GUILDINVITE = 104;
        public const int ALLYSHOOT = 49;
        public const int ENEMYSHOOT = 35;
        public const int REQUESTTRADE = 5;
        public const int TRADEREQUESTED = 88;
        public const int TRADESTART = 86;
        public const int CHANGETRADE = 56;
        public const int TRADECHANGED = 28;
        public const int ACCEPTTRADE = 36;
        public const int CANCELTRADE = 91;
        public const int TRADEDONE = 34;
        public const int TRADEACCEPTED = 14;
        public const int CLIENTSTAT = 69;
        public const int CHECKCREDITS = 102;
        public const int ESCAPE = 105;
        public const int FILE = 106;
        public const int INVITEDTOGUILD = 77;
        public const int JOINGUILD = 7;
        public const int CHANGEGUILDRANK = 37;
        public const int PLAYSOUND = 38;
        public const int GLOBAL_NOTIFICATION = 66;
        public const int RESKIN = 51;
        public const int PETUPGRADEREQUEST = 16;
        public const int ACTIVE_PET_UPDATE_REQUEST = 24;
        public const int ACTIVEPETUPDATE = 76;
        public const int NEW_ABILITY = 41;
        public const int PETYARDUPDATE = 78;
        public const int EVOLVE_PET = 87;
        public const int DELETE_PET = 4;
        public const int HATCH_PET = 23;
        public const int ENTER_ARENA = 17;
        public const int IMMINENT_ARENA_WAVE = 50;
        public const int ARENA_DEATH = 68;
        public const int ACCEPT_ARENA_DEATH = 80;
        public const int VERIFY_EMAIL = 39;
        public const int RESKIN_UNLOCK = 107;
        public const int PASSWORD_PROMPT = 79;
        public const int QUEST_FETCH_ASK = 98;
        public const int QUEST_REDEEM = 58;
        public const int QUEST_FETCH_RESPONSE = 6;
        public const int QUEST_REDEEM_RESPONSE = 96;
        public const int PET_CHANGE_FORM_MSG = 53;
        public const int KEY_INFO_REQUEST = 94;
        public const int KEY_INFO_RESPONSE = 63;
        public const int CLAIM_LOGIN_REWARD_MSG = 3;
        public const int LOGIN_REWARD_MSG = 93;
        public const int QUEST_ROOM_MSG = 48;
        public const int PET_CHANGE_SKIN_MSG = 33;
        public const int REALM_HERO_LEFT_MSG = 84;
        public const int RESET_DAILY_QUESTS = 52;

        public static void MapInfo(Session session, GameWorld gameWorld)
        {
            var offset = 0;
            ref var spanReference = ref MemoryMarshal.GetReference(session.SendMemory.Span);
            WriteInt8(ref offset, ref spanReference, MAPINFO);
            WriteInt32(ref offset, ref spanReference, gameWorld.Width);
            WriteInt32(ref offset, ref spanReference, gameWorld.Height);
            WriteUTF16(ref offset, ref spanReference, gameWorld.Name);
            WriteUTF16(ref offset, ref spanReference, gameWorld.Name);
            WriteUTF16(ref offset, ref spanReference, gameWorld.Name);
            WriteInt32(ref offset, ref spanReference, 0);
            WriteInt32(ref offset, ref spanReference, 0);
            WriteInt32(ref offset, ref spanReference, 0);
            WriteBoolean(ref offset, ref spanReference, false);
            WriteBoolean(ref offset, ref spanReference, false);
            WriteInt16(ref offset, ref spanReference, 0);
            WriteUTF16(ref offset, ref spanReference, "");
            WriteInt32(ref offset, ref spanReference, 0);
            session.Send(offset);
        }

        public static void CreateSuccess(Session session, int characterId, int objectId)
        {
            var offset = 0;
            ref var spanReference = ref MemoryMarshal.GetReference(session.SendMemory.Span);
            WriteInt8(ref offset, ref spanReference, CREATE_SUCCESS);
            WriteInt32(ref offset, ref spanReference, characterId);
            WriteInt32(ref offset, ref spanReference, objectId);
            session.Send(offset);
        }

        public static void Update(Session session, List<Tile> tiles, List<GameObject> newObjs, List<int> drops)
        {
            var offset = 0;
            ref var spanReference = ref MemoryMarshal.GetReference(session.SendMemory.Span);
            WriteInt8(ref offset, ref spanReference, UPDATE);

            WriteInt16(ref offset, ref spanReference, tiles.Count);
            foreach (var tile in tiles)
            {
                WriteInt16(ref offset, ref spanReference, tile.X);
                WriteInt16(ref offset, ref spanReference, tile.Y);
                WriteInt16(ref offset, ref spanReference, tile.Type);
            }

            WriteInt16(ref offset, ref spanReference, newObjs.Count);
            foreach (var newObj in newObjs)
            {
                WriteInt16(ref offset, ref spanReference, newObj.ObjectType);
                WriteInt32(ref offset, ref spanReference, newObj.Id);
                WriteFloat(ref offset, ref spanReference, newObj.X);
                WriteFloat(ref offset, ref spanReference, newObj.Y);
                WriteInt16(ref offset, ref spanReference, 0);
            }

            WriteInt16(ref offset, ref spanReference, drops.Count);
            foreach (var drop in drops)
                WriteInt32(ref offset, ref spanReference, drop);
            session.Send(offset);
        }

        public static void NewTick(Session session)
        {
            //var outgoingPayload = new OutgoingPayload(NEWTICK);
            //session.IOManager.Send(outgoingPayload.GetBuffer());
        }

        public static readonly int RECEIVE_BUFFER_SIZE = 0x1000; // 4096
        public static readonly int SEND_BUFFER_SIZE = 0xFFFF; // 65535

        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static void WriteBoolean(ref int offset, ref byte spanReference, bool value)
        {
            Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, offset), (byte)(value ? 1 : 0));
            offset += sizeof(bool);
        }

        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static void WriteInt8(ref int offset, ref byte spanReference, byte value)
        {
            Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, offset), value);
            offset += sizeof(byte);
        }

        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static void WriteInt16(ref int offset, ref byte spanReference, short value)
        {
            Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, offset), value);
            offset += sizeof(short);
        }

        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static void WriteInt16(ref int offset, ref byte spanReference, int value)
        {
            Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, offset), (short)value);
            offset += sizeof(short);
        }

        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static void WriteInt32(ref int offset, ref byte spanReference, int value)
        {
            Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, offset), value);
            offset += sizeof(int);
        }

        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static void WriteInt64(ref int offset, ref byte spanReference, long value)
        {
            Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, offset), value);
            offset += sizeof(long);
        }


        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static void WriteFloat(ref int offset, ref byte spanReference, float value) => WriteInt32(ref offset, ref spanReference, Unsafe.As<float, int>(ref value));

        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static void WriteFloat(ref int offset, ref byte spanReference, double value)
        {
            var val = (float)value;
            WriteInt32(ref offset, ref spanReference, Unsafe.As<float, int>(ref val));
        }

        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static void WriteDouble(ref int offset, ref byte spanReference, float value)
        {
            var val = (double)value;
            WriteInt64(ref offset, ref spanReference, Unsafe.As<double, int>(ref val));
        }

        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static void WriteDouble(ref int offset, ref byte spanReference, double value)
        {
            var val = (double)value;
            WriteInt64(ref offset, ref spanReference, Unsafe.As<double, int>(ref val));
        }

        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static void WriteUTF16(ref int offset, ref byte spanReference, string value)
        {
            WriteInt16(ref offset, ref spanReference, (short)value.Length);

            var bytes = Encoding.UTF8.GetBytes(value).AsSpan(); // can probably be done better
            Unsafe.CopyBlockUnaligned(ref Unsafe.Add(ref spanReference, offset), ref MemoryMarshal.GetReference(bytes), (uint)value.Length);
            offset += value.Length;
        }

        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static void WriteUTF32(ref int offset, ref byte spanReference, string value)
        {
            WriteInt32(ref offset, ref spanReference, value.Length);

            var bytes = Encoding.UTF8.GetBytes(value).AsSpan(); // can probably be done better
            Unsafe.CopyBlockUnaligned(ref Unsafe.Add(ref spanReference, offset), ref MemoryMarshal.GetReference(bytes), (uint)value.Length);
            offset += value.Length;
        }
    }

    public sealed class StateManager
    {
        public Session Session { get; }

        public int AccountId { get; set; }
        public int CharacterId { get; set; }

        public GameObject GameObject { get; set; }
        public GameWorld GameWorld { get; set; }

        #region States

        public UpdateState UpdateState { get; set; }

        #endregion

        public bool IsReady { get; set; }

        public StateManager(Session session)
        {
            Session = session;
            UpdateState = new UpdateState(this);
        }

        public void HandleIncoming(ref IncomingPayload payload)
        {
            var id = payload.ReadByte();
            Console.WriteLine("Handle: " + id);
            switch (id)
            {
                case IOHelper.HELLO:
                    HandleHello(ref payload);
                    break;

                case IOHelper.LOAD:
                    HandleLoad(ref payload);
                    break;

                case IOHelper.CREATE:
                    HandleCreate(ref payload);
                    break;

                case IOHelper.UPDATEACK:
                    UpdateState.UpdateAck();
                    break;

                default:
                    Logger.LogDebug($"Unknown Payload Id: {id}");
                    break;
            }
        }

        public void NewTick(double dt)
        {
        }

        static RedisDB RedisDatabase = new RedisDB("127.0.0.1:6379");

        private void HandleHello(ref IncomingPayload payload)
        {
            var buildVersion = payload.ReadUTF16();
            var gameId = payload.ReadInt32();
            var guid = RivestShamirAdleman.Instance.Decrypt(payload.ReadUTF16());
            var password = RivestShamirAdleman.Instance.Decrypt(payload.ReadUTF16());
            var keyTime = payload.ReadInt32();

            var len = payload.ReadInt16();
            var key = payload.ReadBytes(len);
            var mapJson = payload.ReadUTF32();
            var userToken = payload.ReadUTF16();
            var something = payload.ReadUTF16();
            var previousConnectionGuid = payload.ReadUTF16();

            var accountId = RedisDatabase.IsValidLogin(guid, password);
            if (accountId == -1)
            {
                Console.WriteLine("Unable to locate account");
                return;
            }

            Console.WriteLine($"Found accountId: {accountId}");
            // todo

            GameWorld = GameWorldManager.FindWorld(gameId);

            IOHelper.MapInfo(Session, GameWorld);
        }

        private void HandleLoad(ref IncomingPayload payload)
        {
            var characterId = payload.ReadInt32();
            var isFromArena = payload.ReadBoolean();

        }

        private void HandleCreate(ref IncomingPayload payload)
        {
            var classType = payload.ReadInt16();
            var skinType = payload.ReadInt16();

            var go = new GameObject()
            {
                X = 32.5f,
                Y = 32.5f,
                ObjectType = 0x030e
            };

            GameWorld.AddObject(go);

            GameObject = go;
            CharacterId = 0;

            IOHelper.CreateSuccess(Session, 0, go.Id);

            IsReady = true;
        }

        private void EnterGame() 
        {
        }

        private void LeaveGame()
        {
        }
    }

    public sealed class UpdateState
    {
        private readonly StateManager StateManager;
        private readonly Dictionary<int, GameObject> VisibleObjects;
        private readonly List<int> VisibleTiles = new List<int>();

        private readonly List<int> PendingVisibleTiles;
        private readonly Dictionary<int, GameObject> PendingVisibleObjects;
        private readonly Dictionary<int, GameObject> PendingDroppedObjects;

        public UpdateState(StateManager stateManager)
        {
            StateManager = stateManager;

            VisibleObjects = new Dictionary<int, GameObject>();
            PendingVisibleTiles = new List<int>();
            PendingVisibleObjects = new Dictionary<int, GameObject>();
            PendingDroppedObjects = new Dictionary<int, GameObject>();
        }

        public void AddVisibleObject(GameObject gameObject)
        {
            PendingVisibleObjects.Add(gameObject.Id, gameObject);
        }

        public void UpdateAck()
        {
            foreach (var obj in PendingVisibleObjects.Values)
                VisibleObjects.Add(obj.Id, obj);
            PendingVisibleObjects.Clear();

            foreach (var hash in PendingVisibleTiles)
                VisibleTiles.Add(hash);
            PendingVisibleTiles.Clear();

            foreach (var obj in PendingDroppedObjects.Values)
                _ = VisibleObjects.Remove(obj.Id);
            PendingDroppedObjects.Clear();
        }

        public void HandleUpdate()
        {
            // update packet for player
            if (!DoUpdate)
                return;

            var go = StateManager.GameObject;
            var world = StateManager.GameWorld;

            var tiles = new List<Tile>();
            for (var x = -15; x <= 15; x++)
                for (var y = -15; y <= 15; y++)
                    if (x * x + y * y <= 15 * 15)
                        tiles.Add(world.Tiles[x + (int)go.X, y + (int)go.Y]);

            var newObjs = new List<GameObject>();
            if (!VisibleObjects.ContainsKey(StateManager.GameObject.Id))
                newObjs.Add(StateManager.GameObject);

            IOHelper.Update(StateManager.Session, tiles, newObjs, new List<int>());
            //DoUpdate = false;
        }

        private bool DoUpdate =true;

        public void NewState(double dt)
        {
            HandleUpdate();
            IOHelper.NewTick(StateManager.Session);
        }
    }

    public sealed class Session
    {
        public Application Application { get; }

        public Guid Id { get; private set; }
        public StateManager StateManager { get; private set; }

        public Socket Socket { get; private set; }
        public Memory<byte> SendMemory { get; private set; }
        public Memory<byte> ReceiveMemory { get; private set; }

        public Session(Application application, Socket socket)
        {
            Application = application;
            Socket = socket;

            Id = Guid.NewGuid();

            SendMemory = GC.AllocateArray<byte>(IOHelper.SEND_BUFFER_SIZE, true).AsMemory();
            ReceiveMemory = GC.AllocateArray<byte>(IOHelper.RECEIVE_BUFFER_SIZE, true).AsMemory();

            StateManager = new StateManager(this);
        }

        public bool Disconnected { get; private set; }

        public async void Start()
        {
            try
            {
                while (Socket.Connected)
                {
                    // might overshoot if we dont have
                    var length = await Socket.ReceiveAsync(ReceiveMemory);
                    if (length == 0 || length >= ReceiveMemory.Length)
                    {
                        Stop();
                        break;
                    }

                    TimedProfiler.Time("Handle", () =>
                    {
                        var position = 0;
                        while (position < length)
                        {
                            var payload = new IncomingPayload(ReceiveMemory, position);
                            StateManager.HandleIncoming(ref payload);
                            position += payload.Position;
                        }
                    });
                }
            }
            catch (SocketException e)
            {
                Console.WriteLine($"[OnReceiveHeader] Exception -> {e.Message} {e.StackTrace}");
                Stop();
            }

            //var receiveBuffer = new byte[4096]; // 4096 should be enough for a packet
            //_ = Socket.BeginReceive(receiveBuffer, 0, 4, SocketFlags.None, OnReceiveHeader, receiveBuffer);
        }

        //pri}vate void OnReceiveHeader(IAsyncResult asyncResult)
        //{
        //    if (Disconnected)
        //        return;

        //    try
        //    {
        //        var receiveBuffer = (byte[])asyncResult.AsyncState!;
        //        var receviedBytes = Socket.EndReceive(asyncResult);
        //        if (receviedBytes > receiveBuffer.Length || receviedBytes != 4)
        //        {
        //            // uh oh stinky poopy
        //            Stop();
        //            return;
        //        }

        //        var payloadSize = BitConverter.ToInt32(receiveBuffer, 0) - 4;

        //        // this time we offset by payload length size and start receiving the payload
        //        if (!Disconnected)
        //            _ = Socket.BeginReceive(receiveBuffer, 4, payloadSize, SocketFlags.None, OnReceivePayload, receiveBuffer);
        //    }
        //    catch (SocketException e)
        //    {
        //        Console.WriteLine($"[OnReceiveHeader] Exception -> {e.Message} {e.StackTrace}");

        //        // uh oh stinky poopy
        //        Stop();
        //    }
        //}

        //private void OnReceivePayload(IAsyncResult asyncResult)
        //{
        //    if (Disconnected)
        //        return;

        //    try
        //    {
        //        var receiveBuffer = (byte[])asyncResult.AsyncState!;
        //        var receivedBytes = Socket.EndReceive(asyncResult);

        //        if (receivedBytes > receiveBuffer.Length)
        //        {
        //            // uh oh stinky poopy
        //            // invalid packet payload size will stop overflow of buffer resizing
        //            Stop();
        //            return;
        //        }

        //        //lock (Payloads)
        //        //{
        //        //    Payloads.Enqueue(new IncomingPayload(receiveBuffer, 4, receivedBytes));
        //        //}

        //        var payload = new IncomingPayload(receiveBuffer, 4);
        //        StateManager.HandleIncoming(ref payload);

        //        // reset receive buffer to prevent leakage
        //        Array.Clear(receiveBuffer, 0, receiveBuffer.Length);

        //        // lets start it back up
        //        if (!Disconnected)
        //            _ = Socket.BeginReceive(receiveBuffer, 0, 4, SocketFlags.None, OnReceiveHeader, receiveBuffer);
        //    }
        //    catch (SocketException e)
        //    {
        //        Console.WriteLine($"[OnPayloadHeader] Exception -> {e.Message} {e.StackTrace}");
        //        // uh oh stinky poopy
        //        Stop();
        //    }
        //}

        public async void Send(int offset)
        {
            if (!Socket.Connected)
                return;

            try
            {
                _ = await Socket.SendAsync(SendMemory[..offset]);
            }
            catch (SocketException e)
            {
                Console.WriteLine($"[Send] Exception -> {e.Message} {e.StackTrace}");
                // uh oh stinky poopy
                Stop();
            }
        } 

        public void Stop()
        {
            if (Disconnected)
                return;
            Disconnected = true;
            Socket.Close();
        }
    }
}
