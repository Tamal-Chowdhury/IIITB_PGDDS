##### Module Name - Programming in R

## Session Name - Introduction to R


#Introduction to R

#1.3.1 Basic Arithmatic Operations in R
8 + 5      #Addition
8 - 5      #Subtraction
9 * 2      #Multiplication
9/2        #Division

(2+3)/(5+5)     #Parenthesis

9 %% 2     #Calculating Remainder
3^5        #Calculating exponent


#Relational Operators
8 > 7
8 >= 8
8 < 7
8 == 8
8 <=7


#Built in Functions
sqrt(2)    #Calculating square root of 2
exp(3)     #Exponential of 3

sin(10)  #Sine of 10 in radians
cos(1.572)  #Cosine of 1.572



help(log)
?log

log10(10)


#Operators & Functions can work within a function (Composite functions)
sin(log10(sqrt(9-8)))             #Take care of parenthesis


#1.3.2 Variable

x <- 5     #Assign the value to the variable
x          #Print x

y = 6
y

x == y     # Checking if x is equal to y

9 == 9

cars <- 3
scooters <- 4

cars + scooters       #Addition of two variables

Karan007 <- 23        #Correct Variable Name
007Karan <-  24       #Wrong Variable Name

RAHUL <- 10          #R is case-sensitive
rahul <- 9
Rahul <- 8


# #True and false are logical or boolean values.  R reads True as 1 and False as 0.

TRUE == FALSE
TRUE > FALSE

##Can mathematical operators be applied on strings?

"my" + "apples"

##How will you check type of variables?
##function class(x) to see which type x belongs to.

class ("my")
class(5.325)

#Difference between class & type of
typeof("apple")
typeof(5.325)
typeof(0)

x = 4.65
class(x)

class(8 == 6)



#Creating Vectors
# c is a shorthand of combine
age <- c(23, 43, 53, 24, 61, 35, 36, 42, 20, 54)

age

my_number <- c(3, 8, 9, 10)
my_number
class(my_number)


y <- c(1.4, "ten")        #R converts y into a Character vector
y
class(y)

# This type of conversion is called Coercion.

class(c(FALSE, 3, "twelve"))
class(c(FALSE, 3))
class(c(FALSE))


##1.4.2 Vector Operations

#Accessing Vector elements
my_vector <- c(3, 8, 9, 10)
my_vector[3]                           #Accessing 3rd element of my_vector
my_vector[2:4]                         #Accessing last 3 elements of my_vector


##Index in R starts from 1

#Stripping

my_vector[-3]   #Returns all elements other than 3rd elements

##Stripping means just not printing some elements. Original Vector remains the same



#Performing different Operations on vectors
my_vector1 <- c(1,3,5,7)
my_vector2 <- c(2,4,6,8)
added_vector <- my_vector1 + my_vector2
added_vector


#Applying functions on Vectors
my_vector1 <- c(1,3,5,7)
min(my_vector1)
sort(my_vector1)



# Used when data set contains unknown variables!

my_vector2 <- c(1, 3, 5, NA, 7, NA)
is.na(my_vector2)

hieghts <- c("medium", "short", "short", "tall", "medium", "medium")
hieghts
hieghts[1] <- "Ultra-short"
hieghts

#Converting this into factors

hieghts <- c("medium", "short", "short", "tall", "medium", "medium")
factor_hieghts <- factor(hieghts)
factor_hieghts
levels(factor_hieghts)
factor_hieghts[1] <- "Ultra-short"     #This will not work
factor_hieghts
summary(factor_hieghts)


## VVI Fact about vector

A_vector <- c(1, 2, 3)
B_vector <- c(4, 5, 6)

# Take the sum of A_vector and B_vector
total_vector <- A_vector + B_vector

# Print out total_vector
total_vector
#[1] 5 7 9

A <- c(1, 2, 3)
B <- c(1, 2, 3)
name <- c(1, 2, 3)
names(A) <- name
names(B) <- name
A
#1 2 3
#1 2 3
B
# 1 2 3
# 1 2 3
type(names(A))
Error: could not find function "type"

c <- A + B
c
# 1 2 3
# 2 4 6
names(B) <- c(12, 13, 14)
B
# 12 13 14
# 1  2  3
A
# 1 2 3
# 1 2 3
B[12]
# <NA>
# NA
B['12']
# 12
# 1
A + B
# 1 2 3
# 2 4 6
B + A
# 12 13 14
# 2  4  6
# Poker and roulette winnings from Monday to Friday:
poker_vector <- c(140, -50, 20, -120, 240)
roulette_vector <- c(-24, -50, 100, -350, 10)
days_vector <- c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday")
names(poker_vector) <- days_vector
names(roulette_vector) <- days_vector

# Define a new variable based on a selection
poker_midweek <- poker_vector[c(2, 3, 4)]

# Which days did you make money on poker?
selection_vector <- poker_vector > 0

# Print out selection_vector
selection_vector

# Select from poker_vector these days
poker_winning_days <- poker_vector[selection_vector]

# mylist <- list( x = c(1,2,3), y = c(50,60,70))
# print(mylist)
# $x [1] 1 2 3
# $y [1] 50 60 70
# If we want to access "60" from this list, we can write print(mylist[[2]][2]) mylist[2][2] gives NULL as output. I think, this is the reason where double brackets can be useful. Otherwise mylist[2] and mylist[[2]] will give the same result. Hope it helps.
#how to delete/remove a directory and it's associated sub-directories?
#unlink(<dir> , recursive=TRUE)


#R has a concept of NULL and NA. While NA is used more often in a logical sense,
# both are used to represent undefined or missing values. Here's what the R documentation
# says NULL represents the null object in R: it is a reserved word. NA is a logical
# constant of length 1 which contains a missing value indicator And hence you cannot
# have one of the values of a vector as NULL, since Null is an object and has type of
# its own But you can use NA. For any vector NA represents a missing value. On the contrary
# you can use NULL inside lists or data frames, since they can have objects as one of their
# elements.


# From what i read in R documentation on its memory handling, each vector can have a
# lenth of 2^31 , about 2 billion elements. So i believe paragraphs of information
# should not be an issue

# builtins() - Shows all the inbuilt function present in R.
# help(package=swirl)  : this function provides the Documention of swirl package.
# lsf.str("package:swirl") : this function displays all functions available in swirl package.


#Difference between <-  and = in R.
# While more or less they are same, the only difference is in their scope.
# Consider these examples
##Delete x (if it exists)
rm(x)
#mean(x=1:10) #[1] 5.5
#x #Error: object 'x' not found

#Here x is declared within the function's scope of the function, so it doesn't exist in the user workspace. Now, let's run the same piece of code with using the <- operator:
mean(x <- 1:10)# [1] 5.5
#x # [1] 1 2 3 4 5 6 7 8 9 10

# This time the x variable is declared within the user workspace
# It seems the R community in general recommends/prefers using the <- operator over the = operator
# Also <- operator also makes it compatible with the older S-Plus

# say we create a numeric vector to store values of a die roll:
dice <- c(1, 2, 4, 5, 5, 3, 2, 6, 3, 5, 6, 2, 1, 4, 3, 6, 5, 3, 2, 2, 5)
#We can convert the vector into 6 factor levels.
dice_levels  <-  factor(dice)
dice_levels

summary(dice_levels)

# OMR responses of Objective examination
logical_levels <- factor(c(TRUE,FALSE, TRUE, FALSE,TRUE,TRUE,FALSE,TRUE,TRUE,TRUE))
logical_levels
summary(logical_levels)


# Matrices

matrix(1:9, byrow = TRUE, nrow = 3)

matrix(1:9, byrow = FALSE, nrow = 3)


#Making matrix by combining vectors
karan_dice <- c(3,1,5,7,6,1)
raj_dice <- c(6,1,3,4,6,1)
ajay_dice <- c(2,1,4,2,2,5)

dice_vector <- c(karan_dice, raj_dice, ajay_dice)

dice_matrix <- matrix(dice_vector, nrow = 3, byrow = TRUE)
dice_matrix


#vvi
#matrix_name <- matrix(vector_name, nrow/ncol = <provide_number>, byrow = T/F,
#                     dimnames = list(row_names_vector, col_name_vector)) # order of vectors is important i.e first row then col.

#Alternate solution :
#colnames(matrix_name) = vector_name
#rownames(matrix_name) = vector_name
#To add all the content row wise
#worldwide_vector <- rowSums(star_wars_matrix)
#Data Frames

# # You can use x:y to generate a sequence of integers from x to y with an
# increment of 1. Also, it is possible that x and y are not integers (for example 0.5:2),
# in which case the default increment is still 1 and the numbers are generated till the
# last number is less than y.
#
# paste() -  used to concat 2 or more strings.
#
# paste("Hello", "world", sep=" ")
# [1] "Hello world"
#
# > x <- c("Hello", "World")
# > x
# [1] "Hello" "World"
# > paste(x, collapse="--")
# [1] "Hello--World"
#
#
# > paste(x, "and some more", sep="|-|", collapse="--")
# [1] "Hello|-|and some more--World|-|and some more"


# The paste() function, by default would add a space as a separator until it is specified.
# paste("Hero", "Hiralal") , is actually taken by R as paste("Hero", "Hiralal", sep=" ")



iris           #Built-in data frame in R

head(iris)      #First few obeservations - top part of dataframe
tail(iris)      #Last few observations - bottom part of dataframe

str(iris)

?iris

#Creating a data frame

Player_name <- c("Rohit","Kohli","dhoni")
Total_runs <- c(5000,7200,8900)
Strike_rate <- c("84.22","89.12","87")

team1 <- data.frame(Player_name,Total_runs,Strike_rate)
team1

str(team1)


#stringsAsFactors
#stringsAsFactors is set by default as TRUE

team_char <- data.frame(Player_name,Total_runs,Strike_rate, stringsAsFactors = FALSE)
str(team_char)


#Accessing different elements from Data frame

team1


team1[2,1]                    #Accessing one element
team1["2","Player_name"]


team1[2, ]                    #Accessing second row


team1[ ,2]                    #Accessing first column
team1$Total_runs              #This can also used. More popular


team1[2:3, 1:2]        #Accessing selective rows & columns

team1[1:3,"Total_runs"]



#Data Frame Operations

Player_name <- c("Jadeja","Ashwin","Raina")
Total_runs <- c(1200,1500,5000)
Strike_rate <- c("34","45","80")

team2 <- data.frame(Player_name,Total_runs,Strike_rate)

Complete_team <- rbind(team1,team2)     #Combining two data frames
Complete_team

Player_age <- c(26,25,37)
hit_six <- c(230,123,133)
team3 <- data.frame(Player_age,hit_six)       #Making new data frame
team1_info <<- cbind(team1,team3)             #Cbind another data frame
team1_info

#Alternative
team1_info <<- cbind(team1,Player_age,hit_six) #Cbind two vectors directly


#Applying functions on data frame

nrow(team1_info)                        #Returns number of rows
ncol(team1_info)                        #Returns number of columns

summary(team1_info)                     #Summary analysis of data



#Installing data from files

#Reading data from .txt file
team_from_text_file<- read.table("myfile.txt")
team_from_text_file<

#Reading data from .csv file
team_from_csv <- read.csv("myfile.csv")
team_from_csv




#Lists

team1 <- read.csv("myfile.csv")
team1

Stadiums <- c("Wankhede", "Eden Gardens", "Firozshah Kotla")

Perf_Matrix <- matrix(1:6,nrow=2)

mylist <- list(team1, Stadiums, Perf_Matrix)
mylist

#Creating a named list

mylist <- list(Teaminfo = team1, St = Stadiums, Perf = Perf_Matrix )
mylist

#1.8.2 Accessing elements from list

mylist[[2]]                  #Accessing second elements

mylist[["St"]]             #Alternate
i = 0;
for (score in cars$score)
{

if (score >= mean(cars$score))
{
    cars$perforname[i] <- "Good"
    i = i + 1

}else{

    cars$perforname[i] <- "Average"
    i = i + 1
}
}

x <- 8
f <- function() {
    y <- x + 2
    return(c(x, y))
}
f()

f <- function() {
    x <- 8
    y <- x + 2
    return(c(x, y))
}
y

function_math <- function(x, y){
    z <- x + y
    p <- x * y
    q <- z / p
    return(c(z, p, q))
}
alpha <- function_math(2, 3)
alpha[2]