using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ZP4CS_05
{
    class Item
    {
        [System.Xml.Serialization.XmlElement(IsNullable = false)]
        public int Number { get; set; }
        [System.Xml.Serialization.XmlElement(IsNullable = false)]
        public string Str { get; set; }
        [System.Xml.Serialization.XmlArray(IsNullable = true)]
        public int[] Numbers { get; set; }
    }
}
