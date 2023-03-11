using System;
using Const;

namespace TIMENTON
{
    sealed public class TimeNTon
    {
        static int count; 
        public string name;
        static TimeNTon[] instance = new TimeNTon[Constant.N];
        private TimeNTon() {}
        
        public static TimeNTon Instance()
        {
            DateTime CurrentTime = DateTime.Now;
            if (CurrentTime.Hour >= 16 && CurrentTime.Hour < 18)
            {
                if (count < Constant.N)
                {
                    instance[count] = new TimeNTon();
                    int n = count++;
                    return instance[n];
                }
                else
                {
                    int n = count % Constant.N;
                    count++;
                    return instance[n];
                }
            }
            else if (instance[0] == null)
            {
                count = 1;
                instance[0] = new TimeNTon();
                return instance[0];
            }
            else return instance[0];
        }
    }
}
