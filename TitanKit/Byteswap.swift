#if os(Linux)
import Glibc
#else
import Darwin
#endif

func floatFromInt32(_ input: Int32) -> Float {
    let array = byteArrayFrom(input)
    return typeFromByteArray(array, Float.self)
}

func doubleFromInt64(_ input: Int64) -> Double {
    let array = byteArrayFrom(input)
    return typeFromByteArray(array, Double.self)
}

func byteArrayFrom<T>(_ value: T) -> [UInt8] {
    var value = value
    return withUnsafePointer(to: &value) {
        Array(UnsafeBufferPointer(start: UnsafePointer<UInt8>($0), count: MemoryLayout<T>.size))
    }
}

func typeFromByteArray<T>(_ byteArray: [UInt8], _: T.Type) -> T {
    return byteArray.withUnsafeBufferPointer {
        return UnsafePointer<T>($0.baseAddress!).pointee
    }
}
