import Prelude hiding ((&&),gcd) 

--Pattern Matching Exercises
--Exercise 1
(&&) :: Bool -> Bool -> Bool
(&&) True True = True
(&&) _ _ = False

--Exercise 2 
--XOR using pattern matching
exOr :: Bool -> Bool -> Bool
exOr True False = True
exOr False True = True
exOr _ _ = False

--Exercise 3
--Define if then else using pattern matching
--ifThenElse :: Bool -> Int -> Int -> Int --If bool is true then second argument else give third arguemnt
ifThenElse True n _ = n
ifThenElse _ _ n = n

--Exercise 4a
-- Takes an int between 1 and 12 returns how many days are in the month. Assumes non leap year
daysInMonth :: Int -> Int
daysInMonth 2 = 28
daysInMonth 4 = 30
daysInMonth 6 = 30
daysInMonth 9 = 30
daysInMonth 11 = 30
daysInMonth _ = 31 --Months(1,3,5,7,8,10,12)

--Exercise 4b
--TODO Similar validDate(from previous worksheet)
--Checking if day enetered is a day within the month entered
--validDate :: Int -> Int -> Bool
--validDate ((daysInMonth b) > n) = True
--validDate 31 1 = True --TODO 
--validDate _ _= False
	

--Recursion Exercises
--Exercise 5
--Like a factorial but with + instead of *
sumNumber :: Int -> Int
sumNumber 1 = 1
sumNumber n = n + sumNumber (n-1) 

--Exercise 6
--Sum of first n squares where n is the argument
sumSquares :: Int -> Int
sumSquares 1 = 1
sumSquares n = n^2 + sumSquares (n-1)

--Exercise 7
--Raise the first argument to the power of the second argument
power :: Int -> Int -> Int
power base 0 = 1
power base powerRaised = base * (power base (powerRaised - 1))

--Exercise 8 
--Gives the product of all integers between the two arguments
--If the first argument > second argument return 0
sumFromToAlternate :: Int -> Int -> Int
sumFromToAlternate arg1 arg2 = sum [arg1..arg2] 
--Better done with a guard than a pattern

--Exercise 9


--Exercise 10

--Exercise 11 
--Exercise 5 Guard Version 
sumNumberGuard :: Int -> Int
sumNumberGuard n
	       | n == 1 = 1
	       | otherwise = n + sumNumberGuard(n-1)

--Exercise 6 Guard Version 
sumSquaresGuard :: Int -> Int
sumSquaresGuard n
		| n == 1 = 1
		| otherwise = n^2 + sumSquaresGuard(n-1)

--Exercise 7 Guard Version 
powerGuard :: Int -> Int -> Int
powerGuard base powerRaised
		| powerRaised == 0 = 1
		| otherwise = base * (power base (powerRaised-1))

--Exercise 8 Guard Version 
sumFromToGuard :: Int -> Int -> Int
sumFromToGuard too from 
		| too > from = 0
		| too == from = too
	        | otherwise = from + (sumFromToGuard too (from-1))

--Exercise 9 Guard Version 
--From 0 to lowest number check if both divide leave 0 remainder
gcdGuard :: Int -> Int -> Int
gcdGuard num1 num2
		| num1 == num2 = num1 
		| num1 > num2 = gcdGuard (num1-num2) num2
		| num1 < num2 = gcdGuard (num2-num1) num1
		--no otherwise needed as one of the three guards will always pass. otherwise could be used to throw an error?

--Exercise 10 Guard Version 
--Return largest int that squared isn't larger than the input argument
--Round needed to stop it returning a float
intSquareRoot :: Int -> Int
intSquareRoot number = round $ sqrt (fromIntegral(recursiveGuard number))

recursiveGuard :: Int -> Int
recursiveGuard number 
		| ((truncate(sqrt(fromIntegral number))^2)==number) = number
		| otherwise = recursiveGuard (number -1)


--Round/truncate only to convert float -> int (e.g. 9.0 -> 9)
intSquareRootAlternate number = truncate $ sqrt $ last $ takeWhile (<=number) $ [i^2 | i <- [1..]]
--intSquareRootAlternate number = truncate $ sqrt $ last $ takeWhile (<=number) $ map (^2) [1..]   

--main = do
tests = do
	--print $ True && True
	--print $ False && True
	--print $ exOr False True
	--print $ exOr True True
	--print $ exOr False False
	--print $ sumSquares 3
	--print $ power 2 3
	--print $ sumFromToAlternate 5 8
--	print $ sumFromTo 5 8
--	print $ sumFromTo 5 3
	--print $ power 2 2
	--print $ power 9 3
	--print $ ifThenElse True 5 6
	--print $ ifThenElse False 5 6
--	print $ gcdGuard 8 8
--	print $ gcdGuard 8 12
--	print $ gcdGuard 54 24

	putStrLn "intSquareRoot recurrsive version"
	print $ intSquareRoot 26 
	print $ intSquareRoot 82
	print $ intSquareRoot 7
	print $ intSquareRoot 9

	putStrLn "alternate version"
	print $ intSquareRootAlternate 26 
	print $ intSquareRootAlternate 82
	print $ intSquareRootAlternate 7
	print $ intSquareRootAlternate 9
	putStrLn "EOP"
	
