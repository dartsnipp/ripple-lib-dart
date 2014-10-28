part of ripplelib.core;

abstract class Utils {


  /**
   * Calculates the SHA-256 hash of the input data.
   */
  static List<int> sha256Digest(List<int> input) {
    SHA256 digest = new SHA256();
    digest.add(input);
    return new Uint8List.fromList(digest.close());
  }

  /**
   * Calculates the power of any object that has the * operator.
   *
   * Only powers of 1 or higher are allowed.
   */
  static dynamic pow(dynamic value, int exponent) {
    while(exponent-- > 1)
      value = value * value;
    return value;
  }

  /**
   * Converts the integer to a byte array in little endian. Ony positive integers allowed.
   */
  static Uint8List uintToBytesLE(int val, [int size = -1]) {
    if(val < 0) throw new Exception("Only positive values allowed.");
    List<int> result = new List();
    while(val > 0) {
      int mod = val & 0xff;
      val = val >> 8;
      result.add(mod);
    }
    if(size >= 0 && result.length > size) throw new Exception("Value doesn't fit in given size.");
    while(result.length < size) result.add(0);
    return new Uint8List.fromList(result);
  }

  /**
   * The regular BigInteger.toByteArray() method isn't quite what we often need: it appends a
   * leading zero to indicate that the number is positive and may need padding.
   */
  static Uint8List bigIntegerToBytes(BigInteger b, int numBytes) {
    if (b == null) {
      return null;
    }
    Uint8List bytes = new Uint8List(numBytes);
    Uint8List biBytes = new Uint8List.fromList(b.toByteArray());
    int start = (biBytes.length == numBytes + 1) ? 1 : 0;
    int length = min(biBytes.length, numBytes);
    bytes.setRange(numBytes - length, numBytes, biBytes.sublist(start, start + length));
    return bytes;
  }

}

class LRUMap<K,V> implements Map<K,V> {

  final int capacity;
  final Function onLRURemoved;
  final LinkedHashMap _map;

  LRUMap({int this.capacity: 100, Function this.onLRURemoved}) : _map = new LinkedHashMap.identity();

  V operator [](K key) {
    if(! _map.containsKey(key))
      return null;
    V value = _map.remove(key);
    _map[key] = value;
    return value;
  }

  operator []=(K key, V value) {
    if(_map.length >= capacity && !_map.containsKey(key))
      _removeLRU();
    return _map[key] = value;
  }

  void _removeLRU() {
    K key = _map.keys.first;
    V value = _map.remove(key);
    if(onLRURemoved != null)
      onLRURemoved(key, value);
  }

  @override
  noSuchMethod(Invocation inv) => reflect(_map).delegate(inv);

}