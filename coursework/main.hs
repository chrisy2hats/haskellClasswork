-- MATHFUN
-- Add your student number --TODO Replace this with student number. Don't want to commit student number to Github.
import Data.List(sortBy)
import Data.Ord(comparing)
-- import System.IO(openFile,hGetContents,IOMode(ReadWriteMode))
import Data.Char(isAlpha)

-----------
-- Types --
-----------

---------------------------
-- Define Film type here --
---------------------------

data Film = Film
 { title :: String
 , director :: String
 , yearOfRelease :: Int
 , usersWhoLike :: [String]
 , usersWhoDislike :: [String]
 } deriving (Show,Read,Ord,Eq) --TODO check if all these 4 classes need to be derivived




type User = String --TODO might remove this.Depends on readability of completed program

-----------------------
-- Defining Database --
-----------------------

avatar = Film "Avatar" "James Cameron" 2009 ["Dave", "Amy", "Liz"] ["Olga", "Tim", "Zoe", "Paula"]
testFilm = Film "Blade Runner" "Ridley Scott" 1982 ["Zoe", "Heidi", "Jo", "Kate", "Emma", "Liz", "Dave"] ["Sam", "Olga", "Tim"] --TODO remove these 3 lines. Purely for testing purposes
testFilmAlt = Film "Not Blade Runner" "Not Ridley Scott" 1982 ["Zoe", "Heidi", "Jo", "Kate", "Emma", "Liz", "Dave"] ["Sam", "Olga", "Tim"]
testFilms = [avatar] ++ [testFilm] ++ [testFilm] ++ [testFilm] ++ [testFilmAlt] ++ [avatar]


testDatabase = [
                 Film "Blade Runner" "Ridley Scott" 1982 ["Zoe", "Heidi", "Jo", "Kate", "Emma", "Liz", "Dave"] ["Sam", "Olga", "Tim"]
               , Film "The Fly" "David Cronenberg" 1986 ["Garry", "Dave", "Zoe"] ["Kevin", "Emma", "Heidi", "Jo", "Kate"]
               , Film "Body Of Lies" "Ridley Scott" 2008 ["Garry", "Dave"] ["Bill", "Olga", "Tim", "Zoe", "Paula"]
               , Film "Avatar" "James Cameron" 2009 ["Dave", "Amy", "Liz"] ["Olga", "Tim", "Zoe", "Paula"]
               , Film "Titanic" "James Cameron" 1997 ["Zoe", "Emma", "Paula", "Liz", "Olga", "Dave"] ["Sam", "Wally", "Kate"]
               , Film "The Departed" "Martin Scorsese" 2006 ["Wally", "Liz", "Kevin", "Tim", "Emma"] ["Olga", "Dave", "Kate", "Zoe"]
               , Film "Aliens" "Ridley Scott" 1986 ["Dave", "Garry", "Liz", "Sam", "Wally", "Kate", "Zoe"] ["Tim", "Emma", "Jo", "Olga"]
               , Film "Kingdom Of Heaven" "Ridley Scott" 2005 ["Jo", "Wally", "Emma"] ["Tim", "Garry", "Ian", "Neal"]
               , Film "Alien: Covenant" "Ridley Scott" 2017 ["Kevin", "Tim"] ["Emma", "Jo", "Liz"]
               , Film "E.T. The Extra-Terrestrial" "Steven Spielberg" 1982 ["Dave", "Amy", "Garry", "Ian", "Neal"] ["Jenny", "Kate", "Emma", "Olga"]
               , Film "Bridge of Spies" "Steven Spielberg" 2015 ["Wally", "Sam", "Dave", "Neal"] ["Bill", "Garry", "Ian", "Kate"]
               , Film "Jaws" "Steven Spielberg" 1975 ["Jenny", "Emma", "Bill", "Neal"] ["Sam", "Ian", "Kate"]
               , Film "The Martian" "Ridley Scott" 2015 ["Wally", "Sam", "Dave", "Jo", "Jenny", "Kate", "Emma", "Olga"] ["Ian", "Neal", "Tim", "Liz"]
               , Film "The BFG" "Steven Spielberg" 2016 ["Sam", "Wally", "Dave", "Jo", "Kate"] ["Neal"]
               , Film "The Shawshank Redemption" "Frank Darabont" 1994 ["Dave", "Amy", "Bill", "Garry", "Ian", "Neal", "Kate", "Jenny", "Zoe", "Heidi"] ["Jo"]
               , Film "Gladiator" "Ridley Scott" 2000 ["Olga", "Neal", "Kate", "Garry"] ["Heidi", "Bill", "Sam", "Zoe"]
               , Film "The Green Mile" "Frank Darabont" 1999 ["Kevin", "Tim", "Emma", "Heidi"] ["Kate", "Jenny", "Zoe"]
               , Film "True Lies" "James Cameron" 1994 ["Sam", "Dave"] ["Emma", "Olga", "Jenny", "Zoe"]
               , Film "Super 8" "J J Abrams" 2011 ["Kevin", "Tim", "Emma", "Olga", "Heidi"] ["Emma", "Dave", "Jenny", "Zoe"]
               , Film "Minority Report" "Steven Spielberg" 2002 ["Kevin", "Kate", "Tim", "Emma", "Jenny", "Zoe"] ["Olga", "Heidi"]
               , Film "War Horse" "Steven Spielberg" 2011 ["Garry", "Bill", "Olga", "Jo", "Wally", "Emma", "Tim", "Kate", "Zoe"] ["Heidi", "Jenny", "Sam"]
               , Film "Silence" "Martin Scorsese" 2016 ["Wally", "Emma", "Tim", "Heidi", "Bill", "Jo"] ["Dave", "Olga"]
               , Film "The Terminal" "Steven Spielberg" 2004 ["Kate", "Dave", "Jo", "Wally", "Emma"] ["Heidi"]
               , Film "Star Wars: The Force Awakens" "J J Abrams" 2015 ["Emma", "Wally", "Zoe", "Kate", "Bill", "Dave", "Liz"] ["Olga", "Jo", "Wally"]
               , Film "Hugo" "Martin Scorsese" 2011 ["Wally", "Sam"] ["Kate", "Bill", "Dave"]
               ]

----------------------------------------------
-- Fuctional code. NO "putStrLn" or "print" --
----------------------------------------------

outputFilmTitles :: [Film] -> String --This is functional code as it doesn't have any IO
outputFilmTitles listOfFilms = foldr (++) "" $ map (\film -> title film ++ "\n") listOfFilms

-- outputFilms :: [Film] -> String
-- outputFilms listOfFilms = foldr (++) "" $ map (\)

addFilm :: String -> String -> Int -> [Film] -> [Film]
addFilm  title director yearOfRelease listOfFilms = listOfFilms ++ [Film title director yearOfRelease [] []]

averageFilmRatings :: (Foldable t, Fractional a) => t a -> a --TODO da faq does this mean?
averageFilmRatings listOfNums = sum listOfNums / fromIntegral(length listOfNums)

-- addFilmProper :: String -> String -> Int -> [Film] -> [Film]
-- addFilmProper title director yearOfRelease listOfFilms = listOfFilms ++ [(Film title director yearOfRelease [] [])]

likeFilm :: User -> Film -> Film --Needs to take a
likeFilm user (Film title director yearOfRelease usersWhoLike usersWhoDislike) = Film title director yearOfRelease (usersWhoLike ++ [user]) usersWhoDislike --TODO check they havent already liked the film

addUserLikeToDatabase :: String -> String -> [Film] -> [Film]
addUserLikeToDatabase user filmToLike listOfFilms = [(likeFilm user $ getFilmToLike filmToLike listOfFilms)] ++ (getOtherFilms filmToLike listOfFilms)

addUserDislikeToDatabase :: String -> String -> [Film] -> [Film]
addUserDislikeToDatabase user filmToLike listOfFilms = [(dislikeFilm user $ getFilmToLike filmToLike listOfFilms)] ++ (getOtherFilms filmToLike listOfFilms)

getFilmToLike :: String -> [Film] -> Film --TODO returns "Exception: Prelude.head: empty list" if filmToLike is not in the listOfFilms
getFilmToLike filmToLike listOfFilms = head $ filter (\film -> title film == filmToLike) listOfFilms --TODO using `head` here seems kinda hacky

getOtherFilms :: String -> [Film] -> [Film]
getOtherFilms filmToLike listOfFilms = filter (\film -> title film /= filmToLike) listOfFilms

dislikeFilm :: User -> Film -> Film
dislikeFilm user (Film title director yearOfRelease usersWhoLike usersWhoDislike) = Film title director yearOfRelease usersWhoLike  (usersWhoDislike ++ [user]) --TODO check they havent already disliked the film

getRatingOfFilm :: Fractional a => Film -> a
getRatingOfFilm film = (\film -> fromIntegral(length $ usersWhoLike film) / fromIntegral((length $ usersWhoDislike film)+(length $ usersWhoLike film))) film

filterByRating :: [Film] -> Float -> [Film]
filterByRating listOfFilms rating = filter (\film -> getRatingOfFilm film >= rating) listOfFilms

filterFilmByDirector :: String -> [Film] -> [Film]
filterFilmByDirector directorName listOfFilms = filter (\film -> director film == directorName) listOfFilms

filterFilmsByYearOfRelease :: Int -> Int -> [Film] -> [Film]
filterFilmsByYearOfRelease lowerBound upperBound listOfFilms = filter (\film -> (yearOfRelease film >= lowerBound) && yearOfRelease film <= upperBound) listOfFilms

getListOfFilmsUserHasRated :: String -> [Film] -> [Film] -- TODO compact 1 liner vs more split out function?
getListOfFilmsUserHasRated user films = filter (\film -> (elem user $ usersWhoLike film) || (elem user $ usersWhoDislike film)) films


----------------------------------------------------------------------------
-- Demo function to test basic functionality (without persistence - i.e.  --
-- testDatabase doesn't change and nothing is saved/loaded to/from file). --
----------------------------------------------------------------------------

--demo 1  = putStrLn all films after adding 2018 film "Sherlock Gnomes"
--demo 1  =  printFilm `map` testDatabase
--          directed by by "John Stevenson" to testDatabase
--demo 2  = putStrLn (filmsAsString testDatabase)
--demo 3  = putStrLn all films by "Ridley Scott"
--demo 4  = putStrLn all films with website rating >= 75%
--demo 5  = putStrLn average website rating for "Ridley Scott"
--demo 6  = putStrLn titles of films rated by "Emma" (with likes/dislikes)
--demo 7  = putStrLn all films after "Emma" says she likes "Avatar"
--demo 71 = putStrLn all films after "Emma" says she likes "Titanic"
--demo 72 = putStrLn all films after "Emma" says she dislikes "Jaws"
--demo 8  = films between 2000 and 2006 inclusive sorted by website rating

demo :: Int -> IO ()
demo 1  = putStrLn $ outputDatabase $ addFilm "Sherlock Gnomes" "Guy Ritchie" 2018 testDatabase --TODO Am I expected to handle a film without its director added
demo 2  = putStrLn $ outputDatabase testDatabase
demo 3  = putStrLn $ outputDatabase $ filterFilmByDirector "Ridley Scott" testDatabase
demo 5  = putStrLn $ show $ averageFilmRatings $ map getRatingOfFilm $ filterFilmByDirector "Ridley Scott" testDatabase --TODO Break this down into more standalone functions
demo 4  = putStrLn $ outputDatabase $  filterByRating testDatabase 0.75
demo 6  = putStrLn $ outputFilmTitles $ getListOfFilmsUserHasRated "Emma" testDatabase
demo 7  = putStrLn $ outputDatabase $ addUserLikeToDatabase "Emma" "Avatar" testDatabase
demo 71 = putStrLn $ outputDatabase $ addUserLikeToDatabase "Emma" "Titanic" testDatabase
demo 72 = putStrLn $ outputDatabase $ addUserDislikeToDatabase "Emma" "Jaws" testDatabase
demo 8  = putStrLn $ outputDatabase $ reverse $ filterFilmsByYearOfRelease 2000 2006 $ sortBy (comparing getRatingOfFilm ) testDatabase

-- demo 8 = print $ filterFilmsByYearOfRelease 2000 2006 testDatabase --TODO sort by website rating reverse $ sortBy (comparing getRatingOfFilm ) testDatabase
-----------------------------------------
-- Your user interface code goes  here --
-----------------------------------------

-- printFilm :: Film -> IO ()
-- printFilm film = putStrLn $ "Title: "++ title film ++ "\nDirector: " ++ director film  ++ "\nYear of release: " ++ show (yearOfRelease film) ++ "\nUsers who like: " ++ show(usersWhoLike film)  ++ "\nUsers who dislike: " ++ show (usersWhoDislike film) ++ "\n"
printFilm :: Film -> String
printFilm film = "Title: "++ title film ++ "\nDirector: " ++ director film  ++ "\nYear of release: " ++ show (yearOfRelease film) ++ "\nUsers who like: " ++ show(usersWhoLike film)  ++ "\nUsers who dislike: " ++ show (usersWhoDislike film) ++ "\n"

showFilms :: [Film] -> IO ()
showFilms listOfFilms = print listOfFilms


optionMenu :: String
optionMenu = "Select one of the options below.\n" ++ "1.Add a film\n" ++ "2.List all films in the database\n" ++ "3.List films by a director\n" ++ "4.\n" ++ "5.\n" ++ "6.\n" ++ "7.\n" ++ "8.\n" ++ "Type exit to quit the system"

selectionMade :: String -> IO()
selectionMade "1" = putStrLn "\nfoo"
selectionMade "2" = putStrLn "\nfoo"
selectionMade "3" = print $ addFilm "Sherlock Gnomes" "Guy Ritchie" 2018 testDatabase --TODO Am I expected to handle a film without its director added
selectionMade "4" = putStrLn "\nfoo"
selectionMade "5" = putStrLn "\nfoo"
selectionMade "6" = putStrLn "\nfoo"
selectionMade "7" = putStrLn "\nfoo"
selectionMade "8" = putStrLn "\nfoo"
selectionMade "exit" = return ()
selectionMade n = putStrLn $ "\nInvalid option" ++ n ++ "\n"

outputDatabase :: [Film] -> String
outputDatabase database = foldr (++) "" $ map printFilm database


databaseToFilm :: IO [Film]
databaseToFilm = do
    filmsAsString <- readFile "films.txt"
    return (read filmsAsString :: [Film])

checkNameInput :: String -> Bool
checkNameInput name
            | (name /= filter Data.Char.isAlpha name) = True
            | name == "" = True
            | otherwise = False

getUserName :: [Film] -> IO ()
getUserName database = do
    putStrLn "Enter your name"
    name <- getLine
    if checkNameInput name
        then getUserName database --TODO find a way to tell the user the entered a bad name here
        else ioLoop database name


ioLoop :: [Film] -> String -> IO()
ioLoop database name = do
        putStrLn optionMenu
        response <- getLine
        if response == "exit"
            then writeFile "films.txt" $ show database
            else ioLoop database name


main = do
    database <- databaseToFilm
    putStrLn "Database loaded from films.txt"
    getUserName database --This won't run unless name is used somewhere due to lazy evaluation
    -- name

    -- ioLoop contents name


    putStrLn "EOP"
