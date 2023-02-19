using SGB.Shared;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Xml.Linq;

namespace SGB.GameServer.Resources.Properties
{
    public enum VisibilityType
    {
        Full,
        Path,
        LineOfSight
    }

    public sealed class XMLDungeon
    {
        public const string ROOM_TYPE_START = "start";
        public const string ROOM_TYPE_DEFAULT = "default";
        public const string ROOM_TYPE_BRANCH = "branch";
        public const string ROOM_TYPE_BRANCH_END = "branchEnd";
        public const string ROOM_TYPE_END = "end";

        public readonly string IdName;
        public readonly string DisplayId;
        public readonly int Width;
        public readonly int Height;
        public readonly string DefaultTile;
        public readonly bool CenterStartRoom;
        public readonly bool CenterMap;
        public readonly bool ShowDisplays;
        public readonly bool NoPlayerTeleport;
        public readonly bool NoSave;
        public readonly bool NoTrade;
        public readonly int Difficulty;
        public readonly List<XMLGlobalReplaceTile> GlobalReplaceTiles;
        public readonly List<XMLGlobalPlaceObject> GlobalPlaceObjects;
        public readonly short PlayerLimit;
        public readonly Dictionary<string, List<XMLRoom>> Rooms;
        public readonly List<XMLWallObject> WallObjs;
        public readonly string WallTile;
        public readonly string SurroundWith;
        public readonly VisibilityType VisibilityType;
        public readonly List<XMLAltWallType> XMLAltWallTypes;
        //<MainBranchLen>5</MainBranchLen>
        //<NumSubBranches>8</NumSubBranches>
        //<MinSubBranchLen>1</MinSubBranchLen>
        //<MaxSubBranchLen>2</MaxSubBranchLen>
        //<MinHallwayWidth>2</MinHallwayWidth>
        //<MaxHallwayWidth>2</MaxHallwayWidth>
        //<MinHallwayLen>4</MinHallwayLen>
        //<MaxHallwayLen>6</MaxHallwayLen>
        //<WallObj>
        //   <Obj>Cave Wall</Obj>
        //</WallObj>
        //<WallTile>Composite</WallTile>
        //<SurroundWith>Dark Cobblestone</SurroundWith>
        //<InsurePath>Partial Red Floor</InsurePath>
        //<CenterMap/>
        //<HallwayTile>GhostGround Dark</HallwayTile>
        //<HallwayEndTile>GhostGround Dark</HallwayEndTile>
        //<HelloNotification>showKeyUI</HelloNotification>

        public class XMLAltWallType
        {
            public readonly int A;
            public readonly int B;
            public readonly string Object;

            public XMLAltWallType(XElement elem)
            {
                A = elem.IntAttribute("a");
                A = elem.IntAttribute("b");
                Object = elem.Value;
            }
        }

        public XMLDungeon(XElement elem)
        {
            IdName = elem.StringAttribute("id");
            DisplayId = elem.StringElement("DisplayId", IdName);
            Width = elem.IntElement("Width");
            Height = elem.IntElement("Height");
            DefaultTile = elem.StringElement("DefaultTile", "Empty");
            CenterStartRoom = elem.HasElement("CenterStartRoom");
            CenterMap = elem.HasElement("CenterMap");
            ShowDisplays = elem.HasElement("ShowDisplays");
            NoPlayerTeleport = elem.HasElement("NoPlayerTeleport");
            NoSave = elem.HasElement("NoSave");
            NoTrade = elem.HasElement("NoTrade");
            Difficulty = elem.IntElement("Difficulty");
            GlobalReplaceTiles = elem.Elements("GlobalReplaceTile").Select(_ => new XMLGlobalReplaceTile(_)).ToList();
            GlobalPlaceObjects = elem.Elements("GlobalPlaceObjects").Select(_ => new XMLGlobalPlaceObject(_)).ToList();
            PlayerLimit = elem.ShortElement("PlayerLimit", 65);

            Rooms = new Dictionary<string, List<XMLRoom>>();
            foreach (var roomElem in elem.Elements("Room"))
            {
                var room = new XMLRoom(roomElem);
                if (!Rooms.ContainsKey(room.IdName))
                    Rooms[room.IdName] = new List<XMLRoom>();
                Rooms[room.IdName].Add(room);
            }
            WallObjs = elem.Element("WallObj")?.Elements().Select(_ => new XMLWallObject(_)).ToList();
            WallTile = elem.StringElement("WallTile");
            SurroundWith = elem.StringElement("SurroundWith");
            VisibilityType = (VisibilityType)Enum.Parse(typeof(VisibilityType), elem.StringElement("Visibility", "Full"), true);
            XMLAltWallTypes = elem.Elements("AltWallTypes").Select(_ => new XMLAltWallType(_)).ToList();
        }

        public class XMLWallObject
        {
            public readonly double Probability;
            public readonly string Object;

            public XMLWallObject(XElement elem)
            {
                Probability = elem.DoubleElement("prob", 1.0);
                Object = elem.Value;
            }
        }

        public enum RoomType
        {
            None,
            Rectangle,
            Circle
        }

        public class XMLRoom
        {
            public readonly int MaxCount;
            public readonly double Probability;
            public readonly string IdName;
            public readonly List<string> LocalJMS;
            public readonly List<List<XMLRoomEnemy>> Enemies;
            public readonly RoomType RoomType;

            //<Type>Circle</Type>
            //<MinCircleRadius>10.0</MinCircleRadius>
            //<MaxCircleRadius>10.0</MaxCircleRadius>
            //<FloorTile>Light Sand</FloorTile>
            //<MinRectLen>16</MinRectLen>
            //<MaxRectLen>16</MaxRectLen>
            //<MaxHallwayLen>0</MaxHallwayLen>
            //<MinHallwayLen>0</MinHallwayLen>
            //<MinPadding>0</MinPadding>

            public XMLRoom(XElement elem)
            {
                IdName = elem.StringAttribute("id");
                LocalJMS = elem.Elements("LocalJM").Select(_ => _.Value).ToList();

                Enemies = new List<List<XMLRoomEnemy>>();
                foreach (var enemies in elem.Elements("Enemies"))
                {
                    var list = new List<XMLRoomEnemy>();
                    foreach (var enemy in enemies.Elements("Enemy"))
                        list.Add(new XMLRoomEnemy(enemy));
                    Enemies.Add(list);
                }
            }
        }

        public enum RoomEnemyPosition
        {
            None,
            CenterPlusSalt,
            RandomFocus,
            Center,
            Edge
        }

        public class XMLRoomEnemy
        {
            public readonly double Probability;
            public readonly int Min;
            public readonly int Max;
            public readonly string Enemy;
            public readonly RoomEnemyPosition RoomEnemyPosition;
            public readonly string GroundRestriction;

            public XMLRoomEnemy(XElement elem)
            {
                Probability = elem.DoubleAttribute("prob", 1.0);
                Min = elem.IntAttribute("minNum", 1);
                Max = elem.IntAttribute("maxNum", 1);
                Enemy = elem.Value;
                GroundRestriction = elem.StringAttribute("ground");
                RoomEnemyPosition = (RoomEnemyPosition)Enum.Parse(typeof(RoomEnemyPosition), elem.StringAttribute("position", "None"), true);
            }
        }

        public enum GlobalFuncEnum
        {
            None,
            RandomLinesX,
            RandomLinesY,
            PerlinProb,
            AroundSpawn,
            PerlinMod,
            CGNoise
        }

        public class XMLGlobalReplaceTile
        {
            public readonly GlobalFuncEnum Func;
            public readonly double Dx;
            public readonly double Dy;
            public readonly double Mult;
            public readonly string GroundRestrict;
            public readonly string GroundReplacement;

            public XMLGlobalReplaceTile(XElement elem)
            {
                Func = (GlobalFuncEnum)Enum.Parse(typeof(GlobalFuncEnum), elem.StringAttribute("func", "None"), true);
                Dx = elem.DoubleAttribute("dx");
                Dy = elem.DoubleAttribute("dy");
                Mult = elem.DoubleAttribute("mult");
                GroundRestrict = elem.StringAttribute("groundRestrict");
                GroundReplacement = elem.Value;
            }
        }

        public class XMLGlobalPlaceObject
        {
            public readonly GlobalFuncEnum Func;
            public readonly double Dx;
            public readonly double Dy;
            public readonly double Mult;
            public readonly string GroundRestrict;
            public readonly string Object;

            public XMLGlobalPlaceObject(XElement elem)
            {
                Func = (GlobalFuncEnum)Enum.Parse(typeof(GlobalFuncEnum), elem.StringAttribute("func", "None"), true);
                Dx = elem.DoubleAttribute("dx");
                Dy = elem.DoubleAttribute("dy");
                Mult = elem.DoubleAttribute("mult");
                GroundRestrict = elem.StringAttribute("groundRestrict");
                Object = elem.Value;
            }
        }
    }
}
