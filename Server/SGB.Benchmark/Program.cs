using BenchmarkDotNet.Running;
using SGB.Benchmark.Tests;
using System.Xml.Linq;

var e = new XElement("Player", new XElement("Equipment", "0xa1a, 0xa61, -1, -1, 0xa22, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1"));

//_ = e.FromCommaSepString32("Equipment");
//_ = e.FromCommaSepString32Trim("Equipment");
//_ = e.FromCommaSepString32Replace("Equipment");
//_ = e.FromCommaSepString32BTrim("Equipment");
//_ = e.FromCommaSepString32BReplace("Equipment");

BenchmarkRunner.Run<Benchmark1>();