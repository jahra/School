using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ZP3CS_cv03
{  
    class Fronta
    {
        public Prvek prvni, posledni;

        public void Pridej(int hodnota)
        {
            Prvek novy = new Prvek(hodnota);

            if (posledni != null) posledni.next = novy;
            else prvni = novy;
                       
            posledni = novy;           
        }

        public int Odeber()
        {
            Prvek p = prvni;
            if (prvni == null) throw new Exception("Pokus o odebrani z prazdne fronty");
            prvni = prvni.next;
            return p.value;            
        }

        public bool JePrazdna() { return prvni == null; }

    }
}
