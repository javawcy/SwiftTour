//
//  BasicLangTests.swift
//  
//
//  Created by lowdad on 2022/4/14.
//

import Foundation
import XCTest


final class BasicLang : XCTestCase {
    
    func testLang() {
        //常用的不测试了，只做Java没有的或不同的
        //1.类型转换 && 类型推断
        
        //数值间转换
        let num1 = 3
        let num2 : Double = Double(num1)
        print(num2)
        
        //字符串转换
        let bool = false
        let str1 = String(bool)
        print(str1)
        
        let num3 = 0.1
        let str2 = String(num3)
        print(str2)
        
        //这里有叹号，说明转换不一定成功, 强行unwrap可以通过编译
        let str3 = "2"
        let num4 = Int(str3)
        print(num4!)
        
        //更安全的做法可以利用optional
        let str4 = "22d"
        if let num5 = Int(str4) {
            print(num5)
        } else {
            print("can't convert")
        }
        
        
        //2.类型别名
        typealias MyInt = Int
        
        let num6 : MyInt = 6
        print(num6)
        let str5 = "7"
        if let num7 = MyInt(str5) {
            print(num7)
        } else {
            print("can't convert")
        }
        
        //3.元组 不限制一个类型,可以作为参数和返回值, 用下划线拒收某个值，因为所有值初始化了就必须使用，跟golang有点像
        let t1 = (0, "success")
        print(t1)
        
        let (code, message) = t1
        print("code is \(code) & message is \(message)")
        
        let (_ , errMsg) = t1
        print(errMsg)
        
        //4.问号隐式optional,问号修饰需要!强行unwarp或optinal
        let op : String? = "hello"
        print(op!)
        
        //5.类型判断 & 获取
        let someStr = "hello"
        //print(someStr is String)
        print(type(of: someStr))
        
        //6.空运算符
        let a : String? = nil
        let b = a ?? "b"
        print(b)
        
        //7.区间运算符 开区间，半开区间
        for i in 1...6 {
            print(i)
        }
        
        for i in 1..<6 {
            print(i)
        }
        
        //8.多行字符串
        let longStr = """
            
            Hello, this is
                long
                    str
        
        """
        print(longStr)
        
        //9.字符串是值类型,func中的str是不可变的
        
        //10.获取字符串中的每一个字符
        for character in "hello, world" {
            print(character)
        }
        
        //11.字符串长度
        print("hello".count)
        
        //12.集合类型只有 Array,Set,Dictionary
        let arr = [1,2,3]
        let typedArr = Array<Int>()
        let set = Set<Int>()
        
        print(arr)
        print(typedArr)
        print(set)
        
        //13.数组常用方法
        var testArr = [1,2,3]
        //增删改查
        testArr.append(4)
        testArr += [5,6,7]
        testArr.insert(8, at: testArr.count)
        testArr.remove(at: 0)
        print(testArr[1])
        print(testArr[0...3])
        print(testArr.index(after: 5))
        
        //14.Set中通过hashValue判断唯一，协议为Hashable
        var testSet = Set<Int>()
        testSet.insert(1)
        testSet.insert(2)
        for v in testSet {
            print(v)
        }
        
        //15.Set操作，取并，取余，取全，取独有
        let setA: Set = [1,2,3]
        let setB: Set = [2,4,6]
        
        print(setA.intersection(setB))
        print(setA.symmetricDifference(setB))
        print(setA.union(setB))
        print(setA.subtracting(setB))
        
        //16.字典跟golang很像，比较牛的是判断一个值存在并修改可以连贯操作
        var testDict = ["key1":"value1"]
        if let oldValue = testDict.updateValue("value2", forKey: "key1") {
            print(oldValue)
            print(testDict["key1"]!)
        } else {
            print("can't find key1")
        }
        
        //17.switch支持值绑定和where, 支持几乎所有的关键字 continue,fallthrough,break,return
        var someNum = 100
        someNum += 1
        switch someNum {
        case let x where x > 10:
            print(x)
        default:
            print("default")
        }
        
        //18.函数跟golang一毛一样
        
        //19.闭包(匿名函数，lambda)
        /*
         
         格式 参数 -> 返回值 in
                闭包逻辑语句
         {
            
            (params) -> returnType in
                statements
         }
         */
        
        //举例排序闭包
        var ints = [4,3,1,5]
        ints = ints.sorted(by:
        //闭包体
            {
            (i1: Int, i2:Int) -> Bool in
                return i1 > i2
            }
        )
        print(ints)
        
        //魔法开始:
        //1.闭包内的参数列表可以根据上下文推断类型,so
        ints = ints.sorted(by:
            {
            (i1,i2) -> Bool in
                return i1 > i2
            }
        )
        print(ints)
        //2.返回值可以推断,所以箭头也没意义了
        ints = ints.sorted(by:
            {
            (i1,i2) in return i1 > i2
            }
        )
        print(ints)
        //3.可以隐式返回，return也可以滚了
        ints = ints.sorted(by:
            {
            (i1,i2) in i1 > i2
            }
        )
        print(ints)
        //4.函数可以通过编号顺序获取
        ints = ints.sorted(by:
            {
                $0 > $1
            }
        )
        print(ints)
        //5.还可以省..wdnmd
        ints = ints.sorted(by:
            >
        )
        print(ints)
        //6.尾随闭包，闭包作为一个参数在最后时，可以写在括号外，so
        ints = ints.sorted() { $0 > $1 }
        print(ints)
        
        //20.闭包的值捕获,正常闭包都有的,闭包是引用类型
        func counter() -> () -> Int {
            var count = 0
            return {
                count += 1
                return count
            }
        }
        let counter1 = counter()
        print(counter1())
        let counter2 = counter()
        print(counter2())
        //count属性被捕捉了，其实就是函数作为变量存在，所以其内部引用值活在了他的scope里
        
        //21.枚举关联值, 枚举是值类型
        enum SomeEnum {
            case phoneNumer(String, Int)
            case idCard(String, String, Int)
        }
        
        let p = SomeEnum.phoneNumer("17600000000", 12)
        let i = SomeEnum.idCard("3745445223", "name", 23)
        print("phone is \(p) & idcard is \(i)")
        
        //22.结构体与类
        
        //结构体是值类型，拥有默认全参构造，不能继承
        
        //23. == 判断值相等 === 判断引用相等
        
        //24. 简化get set,本质就是闭包, 只设置get属性会自动只读
        @propertyWrapper
        struct User {
            var firstName: String
            var lastName: String {
                //25.属性监听
                willSet(newValue) {
                    print("new value will be \(newValue)")
                }
                
                didSet {
                    print("setted")
                }
            }
            var fullName: String {
                get {
                    self.firstName + self.lastName
                }
            }
            //26. 属性包装器。自动调用定义类型的包装闭包, 名字是固定的wrappedValue
            var wrappedValue: String {
                //指定要包装的属性
                get {
                    return firstName
                }
                set {
                    firstName = firstName + newValue
                }
            }
        }
        var u = User(firstName: "Cy", lastName: "Wang")
        u.firstName = "Hello"
        u.lastName = "World"
        u.wrappedValue = "aaa"
        print(u.fullName)
        
        
        
        
    }
    
    
}
