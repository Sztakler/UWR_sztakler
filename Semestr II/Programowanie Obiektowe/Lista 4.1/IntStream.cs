// using System.Collections;
// class IntStream : IStream, IEnumerable
// {
//     int[] IntList;
//     private int value;
//     private int length;
//     public int Length
//     {
//         get
//         {
//             return length;
//         }
//     }
    
//     public IEnumerator GetEnumerator()
//     {
//         return new ;
//     }
//     public int next()
//     {   
//         if (!this.eos())
//         {
//             value++;
//             return value-1;
//         }
//         return value;
//     }

//     public IntStream()
//     {
//         IntList = new int[100];
//     }
//     public bool eos()
//     {
//         return value == int.MaxValue;
//     }

//     public void reset()
//     {
//         value = 0;
//     }
// }


// public class IntEnumerable : IEnumerator
//     public IEnumerator GetEnumerator()
//     {
//         return new IntEnumerator();
//     }
// }

// public class IntEnum :IEnumerator

//     public object Current {get; private set;} = 0;
//     public bool MoveNext()
//     {
//         Current++;
//         return Current > Length;
//     }

// }