-------------
-- MATHFUN --
-- 809059  --
-------------


-------------
-- Imports --
-------------
import Data.Char(isAlpha,isNumber,toLower)
import Data.List(sortBy)
import Data.Ord(comparing)

-----------
-- Types --
-----------

---------------------------
-- Define Film type here --
---------------------------

data Film = Film
 { title           :: String
 , director        :: String
 , yearOfRelease   :: Int
 , usersWhoLike    :: [String]
 , usersWhoDislike :: [String]
 } deriving (Show,Read,Eq,Ord)

-----------------------
-- Defining Database --
-----------------------

testDatabase :: [Film]
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
               , Film "Super 8" "J J Abrams" 2011 ["Kevin", "Tim", "Emma", "Olga", "Heidi"] ["Wally", "Dave", "Jenny", "Zoe"]
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

outputFilmTitles :: [Film] -> String
outputFilmTitles films = foldr (++) "" $ map (\film -> title film ++ "\n") films

addFilm :: String -> String -> Int -> [Film] -> [Film]
addFilm  title director yearOfRelease films = films ++ [Film title director yearOfRelease [] []]

averageFilmRatings :: (Foldable t, Fractional a) => t a -> a
averageFilmRatings listOfNums = sum listOfNums / fromIntegral(length listOfNums)

likeFilm :: String -> Film -> Film
likeFilm user (Film title director yearOfRelease usersWhoLike usersWhoDislike) = Film title director yearOfRelease (usersWhoLike ++ [user]) usersWhoDislike

addUserLikeToDatabase :: String -> String -> [Film] -> [Film]
addUserLikeToDatabase user filmToLike films = [(likeFilm user $ head $ getFilmFromDatabase filmToLike films)] ++ (getOtherFilms filmToLike films)

addUserDislikeToDatabase :: String -> String -> [Film] -> [Film]
addUserDislikeToDatabase user filmToLike films = [(dislikeFilm user $ head $  getFilmFromDatabase filmToLike films)] ++ (getOtherFilms filmToLike films)

removeUserRatingFromFilm :: String -> Film -> Film
removeUserRatingFromFilm user (Film title director yearOfRelease usersWhoLike usersWhoDislike) = Film title director yearOfRelease (filter (/= user) usersWhoLike) (filter (/= user) usersWhoDislike)

getFilmFromDatabase :: String -> [Film] -> [Film]
getFilmFromDatabase filmToGet films = filter (\film -> title film == filmToGet) films

getOtherFilms :: String -> [Film] -> [Film]
getOtherFilms filmToLike films = filter (\film -> title film /= filmToLike) films

dislikeFilm :: String -> Film -> Film
dislikeFilm user (Film title director yearOfRelease usersWhoLike usersWhoDislike) = Film title director yearOfRelease usersWhoLike  (usersWhoDislike ++ [user])

getRatingOfFilm :: Fractional a => Film -> a
getRatingOfFilm film = 100 * (\film -> fromIntegral(length $ usersWhoLike film) / fromIntegral((length $ usersWhoDislike film)+(length $ usersWhoLike film))) film

filterByRating :: [Film] -> Float -> [Film]
filterByRating films rating = filter (\film -> getRatingOfFilm film >= rating) films

filterFilmByDirector :: String -> [Film] -> [Film]
filterFilmByDirector directorName films = filter (\film -> director film == directorName) films

filterFilmsByYearOfRelease :: Int -> Int -> [Film] -> [Film]
filterFilmsByYearOfRelease lowerBound upperBound films = sortBy (comparing  getRatingOfFilm ) $ reverse $ filter (\film -> (yearOfRelease film >= lowerBound) && yearOfRelease film <= upperBound) films

append
 $ sortBy (comparing  getRatingOfFilm)
filmsRatedByUser :: String -> [Film] -> [Film]
filmsRatedByUser user films = filter (\film -> (elem user $ usersWhoLike film) || (elem user $ usersWhoDislike film)) films

filmsLikedByUser :: String -> [Film] -> [Film]
filmsLikedByUser user films = filter (\film -> (elem user $ usersWhoLike film)) films

filmsDislikedByUser :: String -> [Film] -> [Film]
filmsDislikedByUser user films = filter (\film -> (elem user $ usersWhoDislike film)) films

usersWhoHaveRatedFilm :: String -> [Film] -> [String] --This function is utilised in the IO section of the program
usersWhoHaveRatedFilm filmToCheck database = (\film -> usersWhoLike film ++ usersWhoDislike film) $ head $ getFilmFromDatabase filmToCheck database

userHasRatedStringContructor :: String ->  [Film] -> String
userHasRatedStringContructor user films = concat $ map (\film -> (user ++ " likes " ++ (title film) ++ "\n")) (filmsLikedByUser user films) ++ map (\film -> (user ++ " dislikes " ++ (title film) ++ "\n")) (filmsDislikedByUser user films)


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
demo 1  = putStrLn $ outputDatabase $ addFilm "Sherlock Gnomes" "Guy Ritchie" 2018 testDatabase
demo 2  = putStrLn $ outputDatabase testDatabase
demo 3  = putStrLn $ outputDatabase $ filterFilmByDirector "Ridley Scott" testDatabase
demo 4  = putStrLn $ outputDatabase $ filterByRating testDatabase 0.75
demo 5  = putStrLn $ show $ round   $ averageFilmRatings $ map getRatingOfFilm $ filterFilmByDirector "Ridley Scott" testDatabase
demo 6  = putStrLn $ userHasRatedStringContructor "Emma" testDatabase
demo 7  = putStrLn $ outputDatabase $ addUserLikeToDatabase "Emma" "Avatar" testDatabase
demo 71 = putStrLn $ outputDatabase $ addUserLikeToDatabase "Emma" "Titanic" testDatabase
demo 72 = putStrLn $ outputDatabase $ addUserDislikeToDatabase "Emma" "Jaws" testDatabase
demo 8  = putStrLn $ outputDatabase $ filterFilmsByYearOfRelease 2000 2006  testDatabase

-----------------------------------------
-- Your user interface code goes  here --
-----------------------------------------

--This function can be written using one string and \n but it looks horrible
optionMenu :: [Film] -> String -> IO()
optionMenu database name = do
    putStrLn "Select one of the options below."
    putStrLn "1.Add a film"
    putStrLn "2.List all films in the database"
    putStrLn "3.List all films by a director"
    putStrLn "4.Give all films above a certain rating"
    putStrLn "5.Give average rating for a director"
    putStrLn "6.Give titles of all films you have rated"
    putStrLn "7.Like or dislike a film"
    putStrLn "8.Give all films released between two years"
    putStrLn "Type \"exit\" to save and quit the system."
    input <- getLine
    selectionMade input database name

selectionMade :: String  -> [Film] -> String -> IO()
selectionMade "1" database name = addFilmIO database name             --Add a new film to the database
selectionMade "2" database name = outputDatabaseIO database name      --Give all films in the database
selectionMade "3" database name = getFilmsByDirectorIO database name  --Give all films by a given director
selectionMade "4" database name = filmsAboveRatingIO database name    --Give all films above a certain rating
selectionMade "5" database name = ratingOfDirectorIO database name    --Give average website rating for a certain director
selectionMade "6" database name = filmsUserHasRatedIO database name   --Give titles of all films a user has rated
selectionMade "7" database name = likeOrDislikeIO database name       --Allow user to like or dislike a film
selectionMade "8" database name = filmsBetweenYearIO database name    --Give all films between two specified years
selectionMade "exit" database _ = writeAndExit database
selectionMade n database name   = errorMadeInOptionMenu n database name

filmsAboveRatingIO :: [Film] -> String -> IO()
filmsAboveRatingIO database name = do
    putStrLn "What rating do you want films above?"
    threshold <- getLine
    if (not $ elem False $ map Data.Char.isNumber threshold)
        then do
            if ((read threshold :: Int) > 100)
                then do
                    putStrLn "Films can't have a a rating of above 100%"
                    filmsAboveRatingIO database name
                else do
                    if ((read threshold :: Int) < 0)
                        then do
                            putStrLn "Film can't have a rating below 0%"
                            filmsAboveRatingIO database name
                        else do
                        putStrLn $ outputFilmTitles $ filterByRating database (read threshold :: Float)
                        optionMenu database name
    else do
        putStrLn $ "Invalid input: " ++ threshold
        filmsAboveRatingIO database name


getFilmsByDirectorIO :: [Film] -> String -> IO()
getFilmsByDirectorIO database name = do
        putStrLn "Enter director who's films you want."
        director <- getLine
        let films = filterFilmByDirector director database
        if (length films == 0)
            then putStrLn $ "\n The director: " ++ director ++ " hasn't directed any films within our database."
            else do
                 putStrLn $ "\n" ++ director ++ "has directed these films:"
                 putStrLn $ outputFilmTitles $ films
        optionMenu database name

ratingOfDirectorIO :: [Film] -> String -> IO ()
ratingOfDirectorIO database name = do
        putStrLn "Enter the director name to get rating for"
        director <- getLine
        let rating = averageFilmRatings $ map getRatingOfFilm $ filterFilmByDirector director database
        if (isNumberNaN rating)
            then putStrLn "Sorry but there are not rating for any films by that director"
            else putStrLn $ "The average rating for " ++ director ++"\'s films is: " ++  show(round rating)
        optionMenu database name


filmsBetweenYearIO :: [Film] -> String -> IO()
filmsBetweenYearIO database name = do
    putStrLn "Enter the year you want films after"
    lowerBound <- getLine
    putStrLn "Enter the year you want films before"
    upperBound <- getLine
    putStrLn $ "These are the films between " ++ lowerBound ++ " and " ++ upperBound
    putStrLn $ outputDatabase $ filterFilmsByYearOfRelease (read lowerBound :: Int) (read upperBound :: Int) database
    optionMenu database name

outputDatabaseIO :: [Film] -> String -> IO()
outputDatabaseIO database name = do
    if length database == 0 --Can be triggered by having "[]" in films.txt
        then putStrLn "The database is empty!"
        else do
            putStrLn "Start of the database"
            putStrLn $ outputDatabase database
            putStrLn "End of the database"
    optionMenu database name

filmsUserHasRatedIO :: [Film] -> String -> IO()
filmsUserHasRatedIO database name = do
    let ratedFilms = filmsRatedByUser name database
    if  length ratedFilms == 0
        then do
             putStrLn "You haven't rated any films"
             optionMenu database name
        else do
             putStrLn "Films you have rated are:"
             putStrLn $ userHasRatedStringContructor name database
             optionMenu database name

errorMadeInOptionMenu :: String -> [Film] -> String -> IO ()
errorMadeInOptionMenu input database name = do
    putStrLn $ "Invalid input given.\""++input++"\" Returning you to main menu."
    optionMenu database name

writeAndExit :: [Film] -> IO ()
writeAndExit database = do
     putStrLn "Saving database and exiting."
     writeFile "films.txt" $ show database


likeOrDislikeIO :: [Film] -> String -> IO ()
likeOrDislikeIO database name = do
    putStrLn "What film would you like to rate"
    title <- getLine
    let film = getFilmFromDatabase title database
    if length film /= 0
        then do
        if (not $ elem name $ usersWhoHaveRatedFilm title database)
            then do
                putStrLn $ "Would you like to like or dislike " ++ title
                action <- getLine
                if (action == "like" || action == "dislike")
                    then do
                         let newDatabase = if action == "like"
                             then addUserLikeToDatabase name title database
                             else addUserDislikeToDatabase name title database
                         putStrLn "Rating added to film"
                         optionMenu newDatabase name
                    else do
                        putStrLn "Invalid option. Enter either \"like\" or \"dislike\""
                        optionMenu database name
        else do
            putStrLn "You have already rated that film."

            putStrLn "Do you want to re-review that film"
            response <- getLine
            if (map (Data.Char.toLower) response) == "yes"
                then do
                    putStrLn $ "Would you like to like or dislike " ++ title
                    action <- getLine
                    if (action == "like" || action == "dislike")
                        then do
                            if map Data.Char.toLower action == "like"
                                then do
                                    let newDatabase = addUserLikeToDatabase name title $ getOtherFilms title database ++[removeUserRatingFromFilm name $ head $ getFilmFromDatabase title database]
                                    putStrLn "Review updated"
                                    optionMenu newDatabase name
                                else do
                                    let newDatabase = addUserDislikeToDatabase name title $ getOtherFilms title database ++[removeUserRatingFromFilm name $ head $ getFilmFromDatabase title database]
                                    putStrLn "Review updated"
                                    optionMenu newDatabase name

                            else do
                             putStrLn $ "Invalid input" ++ action
                             optionMenu database name
                    else do
                        putStrLn "Ok. Redirecting to main menu"
                        optionMenu database name

    else do
        putStrLn $ "The movie " ++ title ++ " doesn't exist in the database"
        putStrLn "Do you want to rate a different movie. [yes,no]"
        response <- getLine
        if response == "yes"
            then likeOrDislikeIO database name
        else optionMenu database name


addFilmIO :: [Film] -> String -> IO()
addFilmIO database name = do
    putStrLn "Enter the film name"
    title <- getLine
    let film = getFilmFromDatabase title database
    if length film == 0
        then do
        putStrLn "Enter year of release"
        yearOfRelease <- getLine
        if ((read yearOfRelease :: Int) > 2018 || (read yearOfRelease :: Int) < 1900)
            then do
                putStrLn "Invalid year of release"
                optionMenu database name
            else do
                    putStrLn "Enter director name"
                    director <- getLine
                    if (director == filter Data.Char.isAlpha director)
                        then do
                            let newDatabase = addFilm title director (read yearOfRelease :: Int) database
                            putStrLn $ "New film :" ++ title ++ " added to database"
                            optionMenu newDatabase name
                        else do
                            putStrLn "Invalid director input"
                            optionMenu database name
    else do
        putStrLn $ "The film " ++ title ++ " already exists in the database."
        putStrLn $ "Would you like to rate " ++ title ++ "?[yes,no]"
        response <- getLine
        if (map Data.Char.toLower response) == "yes"
            then do
                putStrLn "Transfering you to movie rating now."
                likeOrDislikeIO database name
            else do
                putStrLn "Ok.Transfering you to main menu now"
                optionMenu database name


printFilm :: Film -> String --If statement to avoid "Rating : NaN" being printed.
printFilm film = "\nTitle: "++ title film ++ "\nDirector: " ++ director film  ++ "\nYear of release: " ++ show (yearOfRelease film) ++ "\nRating: " ++ (if isNumberNaN (getRatingOfFilm film) then "0" else  (show $ round $ getRatingOfFilm film) ++ "%")

isNumberNaN :: Float -> Bool --Can't do if num == NaN by IEEE convention
isNumberNaN a = a /= a

outputDatabase :: [Film] -> String
outputDatabase database = concat $ [printFilm film | film <- database]

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
        then getUserName database
        else optionMenu database name

databaseToFilm :: IO [Film]
databaseToFilm = do
    filmsAsString <- readFile "films.txt"
    return (read filmsAsString :: [Film])

main = do
    database <- databaseToFilm
    putStrLn $ outputDatabase database --This line is needed to force haskell to read the entire file. Otherwise it is loaded lazzily and cannot be written to.
    putStrLn "Database loaded from films.txt"
    getUserName database --This function also initiates the main IO loop.
    putStrLn "End of program."
