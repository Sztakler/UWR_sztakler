#include <iostream>

template<class T>
    class AscendingOrder
    {   
        public:
            static bool ordered(T a, T b)
            {
                return a <= b;
            }
    };

template<class T>
    class DescendingOrder
    {
        public:
            static bool ordered(T a, T b)
            {
                return a >= b;
            }
    };

template<class T>
    class AscendingOrder<T*>
    {
        public:
            static bool ordered(T* a, T* b)
            {
                return *a <= *b;
            }
    };

template<class T>
    class DescendingOrder<T*>
    {
        public:
            static bool ordered(T* a, T* b)
            {
                return *a >= *b;
            }
    };

template<>
    class AscendingOrder<const char*>
    {
        public:
            static bool ordered(const char* a, const char*  b)
            {         
                int i = 0;
                char n = a[i];
                char m = b[i];

                while (n != '\0' || m != '\0')
                {
                    if (n > m) return false;
                    i++;
                    n = a[i];
                    m = b[i];
                }

                if(m == '\0') return false;
                return true;   
            }
    };

template<>
    class DescendingOrder<const char*>
    {
        public:
            static bool ordered(const char* a, const char*  b)
            {         
                int i = 0;
                char n = a[i];
                char m = b[i];

                while (n != '\0' || m != '\0')
                {
                    if (n < m) return false;
                    i++;
                    n = a[i];
                    m = b[i];
                }

                if(n == '\0') return false;
                return true;   
            }
    };


template <typename T>
    class List
    {
        private:
            class Node
            {
                public:
                T value;
                Node* next;

                public:
                Node() : next(nullptr){}
                Node(T value) : value(value), next(nullptr){}
                Node(const Node& other);
            };
    

        private:
            Node* head;
        
        public:
            List()
            {
                this->head = new Node();
            }
            List(T value) : List()
            {
                this->head->next = new Node(value);
            }

            void push_back(T value)
            {
                Node* current = this->head;
                while(current->next != nullptr) current = current->next;
                current->next = new Node(value);
            }
           
            List(std::initializer_list<T> init_list) : List()
            {
                for(const T& elem : init_list)
                {
                    this->push_back(elem);
                }
            }

            friend std::ostream& operator<< (std::ostream& os, const List<T>& list)
            {
                Node* curr = list.head->next;
                while(curr != nullptr)
                {
                    os << curr->value << ", ";
                    curr = curr->next;
                }
                return os;
            }

            void insert(T value, int idx)
            {
                Node* current = this->head;
                for(int i = -1; i < idx; i++)
                {
                    if(current->next == nullptr)
                    {
                        current->next = new Node();
                    }
                    current = current->next;

                }
                current->value = value;
            }
            void remove(T value)
            {
                Node* current = this->head;
                int length = this->length();
                for(int i = 0; i < length; i++)
                {
                    if(current->next->value == value) 
                    {
                        
                        Node* to_remove = current->next;
                        current->next = current->next->next;
                        delete(to_remove);
                    }
                    current = current->next;
                }
            }
            int lookup(T value)
            {
                int index = 0;
                Node* current = this->head;

                while(current->value != value)
                {
                    index++;
                    current = current->next;
                    if(current->next == nullptr) throw std::invalid_argument("No such element: " + std::to_string(value));
                }
                return index;
            }
            int length()
            {
                int length = 0;
                Node* current = this->head;

                while(current->next != nullptr)
                {
                    length++;
                    current = current->next;
                }
                return length;
            }

        template<class C, class K = AscendingOrder<T>>
            bool check()
            {
                int length = this->length();
                Node* curr = this->head->next;
                for(int i = 0; i < length - 1; i++)
                {
                    if(! K::ordered(curr->value, curr->next->value)) return false;
                    curr = curr->next;
                }
                return true;
            }

        template<class C, class K = AscendingOrder<T>>
        void sort()
        {   
            int length = this->length();
            Node* ith = this->head->next;
            Node* jth = this->head->next;
            T tmp;
            for(int i = 0; i < length ; i++)
            {
                jth = ith->next;
                for(int j = 0; j < length - i - 1; j++)
                {
                    if(! K::ordered(ith->value, jth->value))
                    {
                        tmp = ith->value;
                        ith->value = jth->value;
                        jth->value = tmp;
                    }
                    jth = jth->next;
                }
                ith = ith->next;
            }
        }

    };
