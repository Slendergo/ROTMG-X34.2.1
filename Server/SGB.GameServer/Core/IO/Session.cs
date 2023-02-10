using Org.BouncyCastle.Asn1.Crmf;
using SGB.GameServer.Utils;
using SGB.Shared;
using System;
using System.Diagnostics;
using System.Net;
using System.Net.Sockets;
using System.Security.Cryptography;

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

        public static void MapInfo(Session session, World world)
        {
            var outgoingPayload = new OutgoingPayload(MAPINFO);
            outgoingPayload.WriteInt32(world.Width);
            outgoingPayload.WriteInt32(world.Height);
            outgoingPayload.WriteUTF16(world.Name);
            outgoingPayload.WriteUTF16(world.Name);
            outgoingPayload.WriteUTF16(world.Name);
            outgoingPayload.WriteInt32(0);
            outgoingPayload.WriteInt32(0);
            outgoingPayload.WriteInt32(0);
            outgoingPayload.WriteBoolean(true);
            outgoingPayload.WriteBoolean(true);
            outgoingPayload.WriteInt16(85);
            outgoingPayload.WriteUTF16("");
            outgoingPayload.WriteInt32(0);
            outgoingPayload.WriteInt16(0);
            outgoingPayload.WriteInt16(0);
            session.IOManager.Send(outgoingPayload.GetBuffer());
        }

        public static void CreateSuccess(Session session, int characterId, int objectId)
        {
            var outgoingPayload = new OutgoingPayload(CREATE_SUCCESS);
            outgoingPayload.WriteInt32(characterId);
            outgoingPayload.WriteInt32(objectId);
            session.IOManager.Send(outgoingPayload.GetBuffer());
        }

        public static void Update(Session session, List<Tile> tiles, List<int> update, List<int> drops)
        {
            var outgoingPayload = new OutgoingPayload(UPDATE);
            outgoingPayload.WriteInt16(tiles.Count);
            foreach (var tile in tiles)
            {
                outgoingPayload.WriteInt16(tile.X);
                outgoingPayload.WriteInt16(tile.Y);
                outgoingPayload.WriteInt32(tile.Type);
            }
            outgoingPayload.WriteInt16(update.Count);
            outgoingPayload.WriteInt16(drops.Count);
            session.IOManager.Send(outgoingPayload.GetBuffer());
        }

        public static void NewTick(Session session)
        {
            var outgoingPayload = new OutgoingPayload(NEWTICK);
            session.IOManager.Send(outgoingPayload.GetBuffer());
        }
    }

    public sealed class StateManager
    {
        public Session Session { get; }

        public int AccountId { get; set; }
        public int CharacterId { get; set; }

        public GameObject GameObject { get; set; }
        public World World { get; set; }

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
            switch (payload.Id)
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

                default:
                    DebugUtils.Log($"Unknown Payload Id: {payload.Id}");
                    break;
            }
        }

        public void NewTick(double dt)
        {
        }

        static RedisDatabase RedisDatabase = new RedisDatabase("127.0.0.1:6379");

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

            World = new World(64, 64, "Nexus");

            IOHelper.MapInfo(Session, World);

            Session.Stop();
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
                X = 32,
                Y = 32,
                ObjectType = 0x030e
            };

            //World.CreateNewObject(go);

            GameObject = go;
            CharacterId = 0;

            EnterGame();

            IOHelper.CreateSuccess(Session, 0, go.Id);
        }

        private void EnterGame() 
        {
            var go = new GameObject()
            {
                X = 32,
                Y = 32,
                ObjectType = 0x030e
            };

            IOHelper.CreateSuccess(Session, CharacterId, GameObject.Id);

            World.AddObject(go);

            IsReady = true;
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

            var go = StateManager.GameObject;
            var world = StateManager.World;

            var tiles = new List<Tile>();
            for (var x = -15; x <= 15; x++)
                for (var y = -15; y <= 15; y++)
                    if (x * x + y * y <= 15 * 15)
                        tiles.Add(world.Tiles[x + (int)go.X, y + (int)go.Y]);
            IOHelper.Update(StateManager.Session, tiles, null, null);
        }

        public void NewState(double dt)
        {
            IOHelper.NewTick(StateManager.Session);
        }
    }

    public sealed class IOManager
    {
        private readonly Session Session;

        public Socket Socket { get; private set; }
        public bool Disconnected { get; private set; }

        public Queue<IncomingPayload> Payloads { get; private set; }

        public IOManager(Session session, Socket socket)
        {
            Session = session;
            Socket = socket;
            Payloads = new Queue<IncomingPayload>();
        }

        public void Start()
        {
            var receiveBuffer = new byte[4096]; // 4096 should be enough for a packet
            _ = Socket.BeginReceive(receiveBuffer, 0, 4, SocketFlags.None, OnReceiveHeader, receiveBuffer);
        }

        private void OnReceiveHeader(IAsyncResult asyncResult)
        {
            if (Disconnected)
                return;

            try
            {
                var receiveBuffer = (byte[])asyncResult.AsyncState!;
                var receviedBytes = Socket.EndReceive(asyncResult);
                if (receviedBytes > receiveBuffer.Length || receviedBytes != 4)
                {
                    // uh oh stinky poopy
                    Stop();
                    return;
                }

                var payloadSize = BitConverter.ToInt32(receiveBuffer, 0) - 4;

                // this time we offset by payload length size and start receiving the payload
                if (!Disconnected)
                    _ = Socket.BeginReceive(receiveBuffer, 4, payloadSize, SocketFlags.None, OnReceivePayload, receiveBuffer);
            }
            catch (SocketException e)
            {
                Console.WriteLine($"[OnReceiveHeader] Exception -> {e.Message} {e.StackTrace}");

                // uh oh stinky poopy
                Stop();
            }
        }

        private void OnReceivePayload(IAsyncResult asyncResult)
        {
            if (Disconnected)
                return;

            try
            {
                var receiveBuffer = (byte[])asyncResult.AsyncState!;
                var receivedBytes = Socket.EndReceive(asyncResult);

                if (receivedBytes > receiveBuffer.Length)
                {
                    // uh oh stinky poopy
                    // invalid packet payload size will stop overflow of buffer resizing
                    Stop();
                    return;
                }

                //lock (Payloads)
                //{
                //    Payloads.Enqueue(new IncomingPayload(receiveBuffer, 4, receivedBytes));
                //}

                var payload = new IncomingPayload(receiveBuffer, 4, receivedBytes);
                Session.StateManager.HandleIncoming(ref payload);

                // reset receive buffer to prevent leakage
                Array.Clear(receiveBuffer, 0, receiveBuffer.Length);

                // lets start it back up
                if(!Disconnected)
                    _ = Socket.BeginReceive(receiveBuffer, 0, 4, SocketFlags.None, OnReceiveHeader, receiveBuffer);
            }
            catch (SocketException e)
            {
                Console.WriteLine($"[OnPayloadHeader] Exception -> {e.Message} {e.StackTrace}");
                // uh oh stinky poopy
                Stop();
            }
        }

        public void Send(Memory<byte> buffer) => _ = SendImpl(buffer);

        private async Task SendImpl(Memory<byte> buffer)
        {
            if (Disconnected)
                return;

            try
            {
                var result = await Socket.SendAsync(buffer);
                if (result != buffer.Length)
                {
                    // uh oh stinky poopy.
                    Stop();
                }
            }
            catch (SocketException e)
            {
                Console.WriteLine($"[Send] Exception -> {e.Message} {e.StackTrace}");
                // uh oh stinky poopy
                Stop();
            }
        }

        //public void Send(byte[] buffer)
        //{
        //    if (Disconnected)
        //        return;

        //    try
        //    {
        //        Socket.BeginSend(buffer, 0, buffer.Length, SocketFlags.None, OnSend, buffer.Length);
        //    }
        //    catch (SocketException e)
        //    {
        //        Console.WriteLine($"[Send] Exception -> {e.Message} {e.StackTrace}");
        //        // uh oh stinky poopy
        //        Stop();
        //    }
        //}

        //private void OnSend(IAsyncResult asyncResult)
        //{
        //    try
        //    {
        //        var expectedLength = (int)asyncResult.AsyncState!;
        //        var result = Socket.EndSend(asyncResult);
        //        if (result != expectedLength)
        //        {
        //            // uh oh stinky poopy.
        //            Stop();
        //        }
        //    }
        //    catch (SocketException e)
        //    {
        //        Console.WriteLine($"[OnPayloadHeader] Exception -> {e.Message} {e.StackTrace}");
        //        // uh oh stinky poopy
        //        Stop();
        //    }
        //}

        public void Stop()
        {
            if (Disconnected)
                return;
            Disconnected = true;
            Socket.Close();
        }
    }

    public sealed class Session
    {
        public Application Application { get; }

        public Guid Id { get; private set; }
        public IOManager IOManager { get; set; }
        public StateManager StateManager { get; private set; }

        public Session(Application application, Socket socket)
        {
            Application = application;

            Id = Guid.NewGuid();

            IOManager = new IOManager(this, socket);
            StateManager = new StateManager(this);
        }

        public void Start()
        {
            IOManager.Start();
        }

        public void Stop()
        {
            IOManager.Stop();
        }
    }
}
