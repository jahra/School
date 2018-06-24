using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Zasobnik
{
    class Prvek<T>
    {
        public T hodnota;
        public Prvek<T> soused;

        public Prvek(T hodnota)
        {
            this.hodnota = hodnota;
        }
    }
}
