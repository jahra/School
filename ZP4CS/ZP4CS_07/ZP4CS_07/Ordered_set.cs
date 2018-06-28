using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Serialization;

namespace ZP4CS_07
{

    /// <remarks/>
    [System.Xml.Serialization.XmlTypeAttribute(AnonymousType = true)]
    [Serializable, XmlRoot("ordered_set")]
    public partial class Ordered_set
    {

        private ordered_setElement[] elementsField;

        private ordered_setOrder[] ordersField;

        public Ordered_set() { }

        /// <remarks/>
        [System.Xml.Serialization.XmlArrayItemAttribute("element", IsNullable = false)]
        public ordered_setElement[] elements
        {
            get
            {
                return this.elementsField;
            }
            set
            {
                this.elementsField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlArrayItemAttribute("order", IsNullable = false)]
        public ordered_setOrder[] orders
        {
            get
            {
                return this.ordersField;
            }
            set
            {
                this.ordersField = value;
            }
        }
    }

    /// <remarks/>
    [System.Xml.Serialization.XmlTypeAttribute(AnonymousType = true)]
    public partial class ordered_setElement
    {

        private ushort xField;

        private ushort yField;

        private string objectsField;

        private string attributesField;

        private byte idField;

        public ordered_setElement() { }

        /// <remarks/>
        public ushort x
        {
            get
            {
                return this.xField;
            }
            set
            {
                this.xField = value;
            }
        }

        /// <remarks/>
        public ushort y
        {
            get
            {
                return this.yField;
            }
            set
            {
                this.yField = value;
            }
        }

        /// <remarks/>
        public string objects
        {
            get
            {
                return this.objectsField;
            }
            set
            {
                this.objectsField = value;
            }
        }

        /// <remarks/>
        public string attributes
        {
            get
            {
                return this.attributesField;
            }
            set
            {
                this.attributesField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlAttributeAttribute()]
        public byte id
        {
            get
            {
                return this.idField;
            }
            set
            {
                this.idField = value;
            }
        }
    }

    /// <remarks/>
    [System.Xml.Serialization.XmlTypeAttribute(AnonymousType = true)]
    public partial class ordered_setOrder
    {

        private byte biggerField;

        private byte smallerField;

        public ordered_setOrder() { } 

        /// <remarks/>
        [System.Xml.Serialization.XmlAttributeAttribute()]
        public byte bigger
        {
            get
            {
                return this.biggerField;
            }
            set
            {
                this.biggerField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlAttributeAttribute()]
        public byte smaller
        {
            get
            {
                return this.smallerField;
            }
            set
            {
                this.smallerField = value;
            }
        }
    }




}
