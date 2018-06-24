using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Zasobnik
{
    class Zasobnik<T> {
        Prvek<T> posledni;

        public void pridejPrvek(T hodnota)
        {
            Prvek<T> p = new Prvek<T>(hodnota);
            if (posledni == null)
            {
                posledni = p;
            }
            else
            {
                p.soused = posledni;
                posledni = p;
            }
        }

        public T Odeber()
        {
            Prvek<T> p = posledni;
            if (posledni == null) throw new Exception("Pokus o odebrani prvku z prazdneho zasobniku");
            posledni = posledni.soused;
            return p.hodnota;
        }

        public bool JePrazdna()
        {
            return posledni == null;
        }

    }
}