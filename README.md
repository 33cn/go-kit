# go-kit

常用工具函数集合。

## 简介

- `cipher` 常用的加解密，目前支持 aescbc，计划支持 aesecb，rsa 等
- `convert` 基本类型转换，进制转换和结构体转成map等
- `file` 文件哈希、文件增删读写、路径判断和文件元数据获取等
- `id-generator` 雪花算法 id 生成、uuid 生成、int64 类型的 base58 和 base62 编解码等
- `math` 浮点数计算比较、奇偶判断、序列生成、最值和平均值计算等
- `rand` 并发安全真随机 A-Za-z0-9 字符串生成（可指定字符串生成源）
- `slice` 切片相关操作，如值包含判断、切片转换、切片打乱和切片去重等
- `time` 时间相关操作，如时区加载、时间戳计算和时间格式化等
- `validator` 通用中文语义结构体参数校验器，并包含银行卡号、身份证号、企业对公账户和统一社会信用代码校验器

## 接口

### cipher

```go
import (
    cryptsUtil "github.com/33cn/go-kit/cipher"
)

type Cipher
    func MustNewAesCbc(key, iv string) Cipher
    func NewAesCbc(key, iv string) (Cipher, error)

// aes
import (
	aesUtil "github.com/33cn/go-kit/cipher/aes"
)

func AesCbcDecrypt(key, iv, src []byte) ([]byte, error)
func AesCbcDecryptBase64(key, iv []byte, msg string) ([]byte, error)
func AesCbcDecryptHex(key, iv []byte, msg string) ([]byte, error)
func AesCbcEncrypt(key, iv, src []byte) ([]byte, error)
func AesCbcEncryptBase64(key, iv, src []byte) (string, error)
func AesCbcEncryptHex(key, iv, src []byte) (string, error)
type AesCbc
    func NewAesCbc(key, iv []byte) (*AesCbc, error)
    func (a *AesCbc) Decrypt(src []byte) ([]byte, error)
    func (a *AesCbc) Encrypt(src []byte) ([]byte, error)

// pkcs
import (
    pkcsUtil "github.com/33cn/go-kit/cipher/pkcs"
)

func PKCS5Padding(cipherText []byte) []byte
func PKCS5Trimming(encrypt []byte) ([]byte, error)
func PKCS7Padding(cipherText []byte, blockSize int) []byte
func PKCS7Trimming(encrypt []byte) ([]byte, error)
```

### convert

```go
import (
    convertUtil "github.com/33cn/go-kit/convert"
)

func BinToDec(bin string) int64
func BinToHex(bin string) string
func BytesEncodeHex(bytes []byte) string
func BytesEncodeHexs(bytes []byte) []byte
func BytesToFloat64(bytes []byte) float64
func BytesToInt64(bytes []byte) int64
func BytesToRunes(bytes []byte) []rune
func BytesToUint64(bytes []byte) uint64
func DecToBin(dec int64) string
func DecToHex(dec int64) string
func Float64ToBytes(f float64) []byte
func HexDecodeBytes(h string) []byte
func HexToBin(hex string) string
func HexToDec(hex string) int64
func HexsDecodeBytes(hs []byte) []byte
func Int64ToBytes(i int64) []byte
func RunesToBytes(runes []rune) []byte
func StructToInterfaceMap(s interface{}, ignoreZeroValue ...bool) map[string]interface{}
func StructToStringMap(s interface{}, ignoreZeroValue ...bool) map[string]string
func ToBase(src string, fromBase, toBase int) string
func ToBool(src interface{}) bool
func ToFloat(src interface{}) float64
func ToFloat32(src interface{}) float32
func ToFloat64(src interface{}) float64
func ToInt(src interface{}) int
func ToInt32(src interface{}) int32
func ToInt64(src interface{}) int64
func ToString(src interface{}) string
func ToUint(src interface{}) uint
func ToUint32(src interface{}) uint32
func ToUint64(src interface{}) uint64
func Uint64ToBytes(i uint64) []byte
```

### file

```go
import (
    fileUtil "github.com/33cn/go-kit/file"
)

func AbsPath(filePath string) (string, error)
func Append(fileName string, data []byte, perm ...os.FileMode) error
func Copy(srcName, destName string, perm ...os.FileMode) error
func Deldir(filePath string) error
func DirSize(rootPath string) (fileNum, dirSize int64)
func Ext(fileName string) string
func Hash(fileName string, h hash.Hash) (string, error)
func IsAbsPath(filePath string) bool
func IsDir(filePath string) bool
func IsExist(filePath string) bool
func IsFile(filePath string) bool
func MD5(fileName string) (string, error)
func Mkdir(filePath string, perm ...os.FileMode) error
func Read(fileName string) ([]byte, error)
func ReadToSlice(fileName string) ([]string, error)
func Remove(fileName string) error
func Rename(oldName, newName string) error
func SHA1(fileName string) (string, error)
func SHA256(fileName string) (string, error)
func SHA512(fileName string) (string, error)
func Size(fileName string) int64
func Write(fileName string, data []byte, perm ...os.FileMode) error
```

### id-generator

```go
// encoding/base58
import (
    base58 "github.com/33cn/go-kit/id-generator/encoding/base58"
)

func StdSource() string
type Encoder
    func MustNewEncoder(source string) *Encoder
    func NewEncoder(source string) (*Encoder, error)
    func (enc *Encoder) Decode(id string) (int64, error)
    func (enc *Encoder) Encode(id int64) string

// encoding/base62
import (
    base62 "github.com/33cn/go-kit/id-generator/encoding/base62"
)

func StdSource() string
type Encoder
    func MustNewEncoder(source string) *Encoder
    func NewEncoder(source string) (*Encoder, error)
    func (enc *Encoder) Decode(id string) (int64, error)
    func (enc *Encoder) Encode(id int64) string

// snowflake
import (
    snowflake "github.com/33cn/go-kit/id-generator/snowflake"
)

func NodeId(nodeId int64) func() (int64, error)
func Parse(id int64, startTime ...time.Time) map[string]int64
type Config
type Snowflake
    func NewSnowflake(c *Config) (*Snowflake, error)
    func (s *Snowflake) NextId() (int64, error)

// uuid
import (
    uuid "github.com/33cn/go-kit/id-generator/uuid"
)
func NextV1() string
func NextV4() string
func Parse(input string) (uuid.UUID, error)
```

### math

```go
import (
    mathUtil "github.com/33cn/go-kit/math"
)

func AbsFloat(num float64) float64
func AbsFloat64(num float64) float64
func AbsInt(num int) int
func AbsInt64(num int64) int64
func Average(nums ...interface{}) float64
func AverageFloat(nums ...float64) float64
func AverageFloat64(nums ...float64) float64
func AverageInt(nums ...int) float64
func AverageInt64(nums ...int64) float64
func Compare(f1, f2 float64, places ...int) int
func Equal(f1, f2 float64, places ...int) bool
func GreaterThan(f1, f2 float64, places ...int) bool
func GreaterThanOrEqual(f1, f2 float64, places ...int) bool
func IsEven(num int64) bool
func IsNegative(f float64) bool
func IsNonNegative(f float64) bool
func IsNonPositive(f float64) bool
func IsOdd(num int64) bool
func IsPositive(f float64) bool
func IsZero(f float64) bool
func LessThan(f1, f2 float64, places ...int) bool
func LessThanOrEqual(f1, f2 float64, places ...int) bool
func Max(nums ...interface{}) float64
func MaxFloat(nums ...float64) float64
func MaxFloat64(nums ...float64) float64
func MaxInt(nums ...int) int
func MaxInt64(nums ...int64) int64
func Min(nums ...interface{}) float64
func MinFloat(nums ...float64) float64
func MinFloat64(nums ...float64) float64
func MinInt(nums ...int) int
func MinInt64(nums ...int64) int64
func NumberFormat(num float64, places int, separator ...string) string
func Percent(num, total interface{}) float64
func RandFloat(min, max float64) float64
func RandFloat64(min, max float64) float64
func RandInt(min, max int) int
func RandInt64(min, max int64) int64
func RangeFloat(start, stop float64, step ...float64) []float64
func RangeFloat64(start, stop float64, step ...float64) []float64
func RangeInt(start, stop int, step ...int) []int
func RangeInt64(start, stop int64, step ...int64) []int64
func Round(f float64, places int) float64
func RoundBank(f float64, places int) float64
func RoundBankToString(f float64, places int) string
func RoundToString(f float64, places int) string
func Sign(f float64) int
func SizeFormat(size float64, places int, separator ...string) string
func Sum(nums ...interface{}) float64
func SumFloat(nums ...float64) float64
func SumFloat64(nums ...float64) float64
func SumInt(nums ...int) int
func SumInt64(nums ...int64) int64
```

### rand

```go
import (
    randUtil "github.com/33cn/go-kit/rand"
)

func NewNumber(length int) string
func NewString(length int) string
func NewWithSource(length int, source string) string
func StdNumberSource() string
func StdSource() string
```

### slice

```go
import (
    sliceUtil "github.com/33cn/go-kit/slice"
)

func Contain(slice, value interface{}) (index int)
func ContainBool(slice []bool, value bool) (index int)
func ContainFloat(slice []float64, value float64, places ...int) (index int)
func ContainFloat32(slice []float32, value float32, places ...int) (index int)
func ContainFloat64(slice []float64, value float64, places ...int) (index int)
func ContainInt(slice []int, value int) (index int)
func ContainInt32(slice []int32, value int32) (index int)
func ContainInt64(slice []int64, value int64) (index int)
func ContainString(slice []string, value string) (index int)
func Count(slice interface{}) map[interface{}]int
func CountBool(slice []bool) map[bool]int
func CountFloat(slice []float64) map[float64]int
func CountFloat32(slice []float32) map[float32]int
func CountFloat64(slice []float64) map[float64]int
func CountInt(slice []int) map[int]int
func CountInt32(slice []int32) map[int32]int
func CountInt64(slice []int64) map[int64]int
func CountString(slice []string) map[string]int
func Delete(slice, value interface{}, n int) ([]interface{}, int)
func DeleteBool(slice []bool, value bool, n int) ([]bool, int)
func DeleteFloat(slice []float64, value float64, n int, places ...int) ([]float64, int)
func DeleteFloat32(slice []float32, value float32, n int, places ...int) ([]float32, int)
func DeleteFloat64(slice []float64, value float64, n int, places ...int) ([]float64, int)
func DeleteInt(slice []int, value, n int) ([]int, int)
func DeleteInt32(slice []int32, value int32, n int) ([]int32, int)
func DeleteInt64(slice []int64, value int64, n int) ([]int64, int)
func DeleteString(slice []string, value string, n int) ([]string, int)
func Equal(arr1, arr2 interface{}) bool
func EqualBools(arr1, arr2 []bool) bool
func EqualFloat32s(arr1, arr2 []float32, places ...int) bool
func EqualFloat64s(arr1, arr2 []float64, places ...int) bool
func EqualFloats(arr1, arr2 []float64, places ...int) bool
func EqualInt32s(arr1, arr2 []int32) bool
func EqualInt64s(arr1, arr2 []int64) bool
func EqualInts(arr1, arr2 []int) bool
func EqualStrings(arr1, arr2 []string) bool
func Extract(slice interface{}, num int) []interface{}
func ExtractBools(slice []bool, num int) []bool
func ExtractFloat32s(slice []float32, num int) []float32
func ExtractFloat64s(slice []float64, num int) []float64
func ExtractFloats(slice []float64, num int) []float64
func ExtractInt32s(slice []int32, num int) []int32
func ExtractInt64s(slice []int64, num int) []int64
func ExtractInts(slice []int, num int) []int
func ExtractStrings(slice []string, num int) []string
func Fill(value interface{}, num int) []interface{}
func FillBool(value bool, num int) []bool
func FillFloat(value float64, num int) []float64
func FillFloat32(value float32, num int) []float32
func FillFloat64(value float64, num int) []float64
func FillInt(value, num int) []int
func FillInt32(value int32, num int) []int32
func FillInt64(value int64, num int) []int64
func FillString(value string, num int) []string
func Float64sToInterfaces(slice []float64) []interface{}
func Float64sToStrings(slice []float64) []string
func FloatsToInterfaces(slice []float64) []interface{}
func FloatsToStrings(slice []float64) []string
func Int64sToInterfaces(slice []int64) []interface{}
func Int64sToStrings(slice []int64) []string
func InterfacesToFloat64s(slice []interface{}) []float64
func InterfacesToFloats(slice []interface{}) []float64
func InterfacesToInt64s(slice []interface{}) []int64
func InterfacesToInts(slice []interface{}) []int
func InterfacesToStrings(slice []interface{}) []string
func IntsToInterfaces(slice []int) []interface{}
func IntsToStrings(slice []int) []string
func Join(slice interface{}, sep ...string) (result string)
func JoinBools(slice []bool, sep ...string) (result string)
func JoinFloat32s(slice []float32, sep ...string) (result string)
func JoinFloat64s(slice []float64, sep ...string) (result string)
func JoinFloats(slice []float64, sep ...string) (result string)
func JoinInt32s(slice []int32, sep ...string) (result string)
func JoinInt64s(slice []int64, sep ...string) (result string)
func JoinInts(slice []int, sep ...string) (result string)
func JoinStrings(slice []string, sep ...string) (result string)
func Reverse(slice interface{}) []interface{}
func ReverseBools(slice []bool) []bool
func ReverseFloat32s(slice []float32) []float32
func ReverseFloat64s(slice []float64) []float64
func ReverseFloats(slice []float64) []float64
func ReverseInt32s(slice []int32) []int32
func ReverseInt64s(slice []int64) []int64
func ReverseInts(slice []int) []int
func ReverseStrings(slice []string) []string
func Shuffle(slice interface{}) []interface{}
func ShuffleBools(slice []bool) []bool
func ShuffleFloat32s(slice []float32) []float32
func ShuffleFloat64s(slice []float64) []float64
func ShuffleFloats(slice []float64) []float64
func ShuffleInt32s(slice []int32) []int32
func ShuffleInt64s(slice []int64) []int64
func ShuffleInts(slice []int) []int
func ShuffleStrings(slice []string) []string
func SplitBools(str string, sep ...string) []bool
func SplitFloat32s(str string, sep ...string) []float32
func SplitFloat64s(str string, sep ...string) []float64
func SplitFloats(str string, sep ...string) []float64
func SplitInt32s(str string, sep ...string) []int32
func SplitInt64s(str string, sep ...string) []int64
func SplitInts(str string, sep ...string) []int
func SplitStrings(str string, sep ...string) []string
func StringsToFloat64s(slice []string) []float64
func StringsToFloats(slice []string) []float64
func StringsToInt64s(slice []string) []int64
func StringsToInterfaces(slice []string) []interface{}
func StringsToInts(slice []string) []int
func Take(slice interface{}) interface{}
func TakeBool(slice []bool) bool
func TakeFloat(slice []float64) float64
func TakeFloat32(slice []float32) float32
func TakeFloat64(slice []float64) float64
func TakeInt(slice []int) int
func TakeInt32(slice []int32) int32
func TakeInt64(slice []int64) int64
func TakeString(slice []string) string
func Unique(slice interface{}) []interface{}
func UniqueBools(slice []bool) []bool
func UniqueFloat32s(slice []float32) []float32
func UniqueFloat64s(slice []float64) []float64
func UniqueFloats(slice []float64) []float64
func UniqueInt32s(slice []int32) []int32
func UniqueInt64s(slice []int64) []int64
func UniqueInts(slice []int) []int
func UniqueStrings(slice []string) []string
```

### time

```go
import (
    timeUtil "github.com/33cn/go-kit/time"
)

func Date(t time.Time, location ...*time.Location) string
func DateTime(t time.Time, location ...*time.Location) string
func DoCycleTask(ctx context.Context, f func(), d time.Duration)
func Format(t time.Time, layout string, location ...*time.Location) string
func HongKong() *time.Location
func Local() *time.Location
func Location(name string) *time.Location
func Now(location ...*time.Location) time.Time
func NowAdd(d time.Duration, location ...*time.Location) time.Time
func NowAddDate(d time.Duration, location ...*time.Location) string
func NowAddDateTime(d time.Duration, location ...*time.Location) string
func NowAddFormat(d time.Duration, layout string, location ...*time.Location) string
func NowAddUnixMicrosecond(d time.Duration, location ...*time.Location) int64
func NowAddUnixMillisecond(d time.Duration, location ...*time.Location) int64
func NowAddUnixNanosecond(d time.Duration, location ...*time.Location) int64
func NowAddUnixSecond(d time.Duration, location ...*time.Location) int64
func NowDate(location ...*time.Location) string
func NowDateTime(location ...*time.Location) string
func NowFormat(layout string, location ...*time.Location) string
func NowUnixMicrosecond(location ...*time.Location) int64
func NowUnixMillisecond(location ...*time.Location) int64
func NowUnixNanosecond(location ...*time.Location) int64
func NowUnixSecond(location ...*time.Location) int64
func Shanghai() *time.Location
func SleepMicrosecond(n int64)
func SleepMillisecond(n int64)
func SleepSecond(n int64)
func StringToTime(str, layout string, location ...*time.Location) (time.Time, error)
func StringToUnix(str, layout string, location ...*time.Location) int64
func UTC() *time.Location
func UnixAddDate(timestamp int64, years, months, days int, location ...*time.Location) time.Time
func UnixAddDays(timestamp int64, days int, location ...*time.Location) time.Time
func UnixAddMonths(timestamp int64, months int, location ...*time.Location) time.Time
func UnixAddYears(timestamp int64, years int, location ...*time.Location) time.Time
func UnixAfter(timestamp1, timestamp2 int64) bool
func UnixBefore(timestamp1, timestamp2 int64) bool
func UnixDifferDays(timestamp1, timestamp2 int64) int
func UnixDifferHours(timestamp1, timestamp2 int64) float64
func UnixEqual(timestamp1, timestamp2 int64) bool
func UnixMicrosecond(t time.Time, location ...*time.Location) int64
func UnixMillisecond(t time.Time, location ...*time.Location) int64
func UnixNanosecond(t time.Time, location ...*time.Location) int64
func UnixSecond(t time.Time, location ...*time.Location) int64
func UnixToTime(timestamp int64, location ...*time.Location) time.Time
func UnixTodayRange(location ...*time.Location) (int64, int64)
```

### validator

```go
import (
    validator "github.com/33cn/go-kit/validator"
)

func ParseErr(err error) string
func Verify(obj interface{}) error
func VerifyVar(field interface{}, tag string) error
func VerifyVarWithValue(field, other interface{}, tag string) error
type BankCard
    func NewBankCard(bankcard string) BankCard
    func (bc BankCard) IsValid() bool
type CorpAccount
    func NewCorpAccount(corpaccount string) CorpAccount
    func (ca CorpAccount) IsValid() bool
type IdCard
    func NewIdCard(idcard string) IdCard
    func (ic IdCard) GetBirthday() (time.Time, error)
    func (ic IdCard) GetGender() (int, error)
    func (ic IdCard) IsFemale() (bool, error)
    func (ic IdCard) IsMale() (bool, error)
    func (ic IdCard) IsValid() bool
type USCC
    func NewUSCC(uscc string) USCC
    func (uscc USCC) IsValid() bool
```
