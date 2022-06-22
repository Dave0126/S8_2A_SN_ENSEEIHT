
class ProtectionProxy:

    def __init__(self, objet, *interdits):
        self._recepteur = objet
        self._interdites = set(interdits)
        print(dir(self.__class__))
        for f in ('__str__', '__repr__', '__getitem__', '__len__'):
        # for f in dir(objet):
            print('f =', f)
            if f not in ('__class__', '__getattribute__', '__getattr__'):
                setattr(self.__class__, f, getattr(objet, f))
        # self.__class__.__str__ = self.recepteur.__str__

    def __getattr__(self, name):
        print('__getattr__: ', name)
        if name in self._interdites:
            raise AttributeError('Forbidden call: ' + name)
        else:
            return getattr(self._recepteur, name)

#    def __getattribute__(self, name):
#        print('__getattribute__: ', name)
#        return super().__getattribute__(name)

def exemple_list():
    l = [2, 3, 5, 7]
    p = ProtectionProxy(l, 'append', 'remove', 'insert')

    l.append(11);
    l.remove(3)

    print('dir(l) =', dir(l))
    print('dir(p) =', dir(p))

    print('p =', p)

    print(len(p))
    print(p[0])

    try:
        p.append(11)
    except Exception as e:
        print(e)

    try:
        p.insert(0, -1)
    except Exception as e:
        print(e)

    print('p =', p)

    print(isinstance(p, list))
    print(isinstance(l, list))

if __name__ == '__main__':
    exemple_list()
