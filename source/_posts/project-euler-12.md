---
title: "Project Euler 12: Highly divisible triangular number"
date: 2020-10-11 18:09:40
tags: 
 - poject euler
---

> The sequence of triangle numbers is generated by adding the natural numbers. So the 7th triangle number would be 1 + 2 + 3 + 4 + 5 + 6 + 7 = 28. The first ten terms would be:
> 
> 1, 3, 6, 10, 15, 21, 28, 36, 45, 55, ...
> 
> Let us list the factors of the first seven triangle numbers:
>  1: 1
>  3: 1,3
>  6: 1,2,3,6
> 10: 1,2,5,10
> 15: 1,3,5,15
> 21: 1,3,7,21
> 28: 1,2,4,7,14,28
> We can see that 28 is the first triangle number to have over five divisors.
> 
> What is the value of the first triangle number to have over five hundred divisors?

这题是要计算出最小的拥有500个因数的三角数。三角数即正整数前n项的和：1, 3, 6, 10, 15, 21, 28, 36, 45, 55, 66, 78,..n(n+1)/2。  

## 想当然
三角数的计算不难：  

````golang
func GetTriangularNumber(n int) int {
	return n * (n + 1) / 2
}
````  

那么问题就转化为拆解正整数的因数了？  

````golang
func ListDivisors(input int) []int {
	var ret []int
	for i := 1; i <= input; i++ {
		if input%i == 0 {
			ret = append(ret, i)
		}
	}
	return ret
}
````  

当然没有那么简单，这种暴力解法即不高效也不优雅。

## 正解
简单补习一下分解质因数：$$n = \prod_{i=1}^{k}p_{i}^{a_{i}} =  p_{1}^{a_{1}} · p_{2}^{a_{2}} ······ p_{k}^{a_{k}}$$  
公式表示 n 可以表示为k个其质因数$p_i$的$a_i$次幂的乘积。  
这个公式应该不难理解，正整数可以分解为该正整数质因数的乘积，如 12 = 2 * 2 * 3，即 $12 = 2^2 * 3^1$。  
即在上述公式中，$k=2$，$p_1=2$, $a_1=2$，$p_2=3$, $a_2=1$  

再补习下正因约个数定理：$$f(n) = \prod_{i=1}^{k}p_{i}^{a_i} = (a_1 + 1)(a_2 + 1)···(a_k + 1)$$  
证明： 
因为 $n = p_1^{a_1} · p_2^{a_2} ····· p_k^{a_k}$，其中 $p_1^{a_1}$ 的因数分别为：$p_1^0$，$p_1^1$ ...... $p_1^{a_1}$，共有 $(a_1 + 1)$ 个。同理 $p_2^{a_2}$ 有 $(a_2 + 1)$ 个 ...... $p_k^{a_k}$ 有 $(a_k + 1)$ 个。
因此，根据乘法定理，n 的因数共有 $(a_1 + 1)(a_2 + 1)···(a_k + 1)$ 个。  

举例：
$12 = 2^2 * 3^1$，其因数为 1, 2, 3, 4, 6, 12。即 $(2 + 1) * (1 + 1) = 6$ 个。

### 编码
由上可知，这个问题可以转化为求正整数的质因数的个数，以及各个质因数出现的次数。在 Project Euler 之前的问题中，我们已经遇到很多次求解质因数的题目了，可以直接拿过来使用。当然需要做点小小的修改：  

````golang
func Tau(num int) int {
	if num == 1 {
		return 1
	}
	n := num
	// 从最小的质数开始
	i := 2
	// 质因数个数的乘积
	p := 1

	for i*i < n {
		c := 1
		for n%i == 0 {
			n /= i
			c++
		}
		i++
		p *= c
	}

	// 未除尽时，最大质因数为包括在内，需要添加
	if n == num || n > 1 {
		p *= 1 + 1
	}

	return p
}
````  

最后在`main` 函数中调用：  
  
````golang
func main() {
	n := 1
	d := 1
	for Tau(d) <= 500 {
		n++
		d += n
	}

	fmt.Println("The first triagular number with 500 divisors is", d)
}
````  


## 后记
Project Euler 是很好的 code kata 练习题库，我将坚持以 TDD 的方式刷完所有题目，并记录下一些在此过程中趟过的坑。