
-- Bookstore Database - Large Sample Data


USE bookstore;

-- Disable foreign key checks temporarily for faster insertion
SET FOREIGN_KEY_CHECKS = 0;
SET AUTOCOMMIT = 0;


-- 1. Insert Publishers (30 publishers)

INSERT INTO publisher (name, address, phone) VALUES
('Penguin Random House', '1745 Broadway, New York, NY 10019', '+1-212-782-9000'),
('HarperCollins Publishers', '195 Broadway, New York, NY 10007', '+1-212-207-7000'),
('Simon & Schuster', '1230 Avenue of the Americas, New York, NY 10020', '+1-212-698-7000'),
('Macmillan Publishers', '120 Broadway, New York, NY 10271', '+1-646-307-5151'),
('Hachette Book Group', '1290 Avenue of the Americas, New York, NY 10104', '+1-212-364-1100'),
('Oxford University Press', 'Great Clarendon Street, Oxford OX2 6DP, UK', '+44-1865-556767'),
('Cambridge University Press', 'University Printing House, Cambridge CB2 8BS, UK', '+44-1223-358331'),
('Springer Nature', 'One New York Plaza, New York, NY 10004', '+1-212-460-1500'),
('John Wiley & Sons', '111 River Street, Hoboken, NJ 07030', '+1-201-748-6000'),
('Scholastic Corporation', '557 Broadway, New York, NY 10012', '+1-212-343-6100'),
('McGraw-Hill Education', '2 Penn Plaza, New York, NY 10121', '+1-212-904-2000'),
('Pearson Education', '221 River Street, Hoboken, NJ 07030', '+1-201-236-7000'),
('Bloomsbury Publishing', '50 Bedford Square, London WC1B 3DP, UK', '+44-20-7631-5600'),
('Tor Books', '120 Broadway, New York, NY 10271', '+1-646-307-5511'),
('Random House', '1745 Broadway, New York, NY 10019', '+1-212-782-9000'),
('W. W. Norton & Company', '500 Fifth Avenue, New York, NY 10110', '+1-212-354-5500'),
('Grove Atlantic', '154 West 14th Street, New York, NY 10011', '+1-212-614-7850'),
('Farrar, Straus and Giroux', '120 Broadway, New York, NY 10271', '+1-212-741-6900'),
('Knopf Doubleday', '1745 Broadway, New York, NY 10019', '+1-212-751-2600'),
('Little, Brown and Company', '1290 Avenue of the Americas, New York, NY 10104', '+1-212-364-1100'),
('Yale University Press', '302 Temple Street, New Haven, CT 06511', '+1-203-432-0960'),
('Princeton University Press', '41 William Street, Princeton, NJ 08540', '+1-609-258-4900'),
('MIT Press', '1 Rogers Street, Cambridge, MA 02142', '+1-617-253-5646'),
('University of Chicago Press', '1427 East 60th Street, Chicago, IL 60637', '+1-773-702-7700'),
('Duke University Press', '905 West Main Street, Durham, NC 27701', '+1-919-688-5134'),
('Columbia University Press', '61 West 62nd Street, New York, NY 10023', '+1-212-459-0600'),
('Harvard University Press', '79 Garden Street, Cambridge, MA 02138', '+1-617-495-2600'),
('Stanford University Press', '425 Broadway Street, Redwood City, CA 94063', '+1-650-723-9434'),
('Routledge', '2 Park Square, Milton Park, Abingdon OX14 4RN, UK', '+44-20-7017-6000'),
('SAGE Publications', '2455 Teller Road, Thousand Oaks, CA 91320', '+1-805-499-0721');


-- 2. Insert Authors (100 authors)

INSERT INTO author (name) VALUES
-- Science Authors
('Stephen Hawking'), ('Carl Sagan'), ('Richard Dawkins'), ('Neil deGrasse Tyson'), ('Brian Greene'),
('Michio Kaku'), ('Sean Carroll'), ('Lisa Randall'), ('Lawrence Krauss'), ('Carlo Rovelli'),
('Stephen Jay Gould'), ('Edward O. Wilson'), ('James Watson'), ('Francis Crick'), ('Charles Darwin'),
('Albert Einstein'), ('Richard Feynman'), ('Steven Weinberg'), ('Roger Penrose'), ('Freeman Dyson'),
-- Art Authors
('Leonardo da Vinci'), ('Michelangelo'), ('Vincent van Gogh'), ('Pablo Picasso'), ('Salvador Dali'),
('Ernst Gombrich'), ('John Berger'), ('Kenneth Clark'), ('Robert Hughes'), ('Simon Schama'),
('Wassily Kandinsky'), ('Paul Cezanne'), ('Claude Monet'), ('Frida Kahlo'), ('Georgia O''Keeffe'),
-- Religion Authors
('Karen Armstrong'), ('Reza Aslan'), ('Dalai Lama'), ('Thich Nhat Hanh'), ('Thomas Merton'),
('C.S. Lewis'), ('Pope Francis'), ('Desmond Tutu'), ('Huston Smith'), ('Elaine Pagels'),
('Joseph Campbell'), ('Mircea Eliade'), ('Martin Buber'), ('Paul Tillich'), ('Hans Kung'),
-- History Authors
('Yuval Noah Harari'), ('Jared Diamond'), ('Howard Zinn'), ('Eric Hobsbawm'), ('Barbara Tuchman'),
('David McCullough'), ('Doris Kearns Goodwin'), ('Simon Schama'), ('Mary Beard'), ('Tom Holland'),
('Ian Kershaw'), ('Timothy Snyder'), ('Margaret MacMillan'), ('Antony Beevor'), ('Max Hastings'),
('Niall Ferguson'), ('Tony Judt'), ('Robert Service'), ('Orlando Figes'), ('Anne Applebaum'),
-- Geography Authors
('Simon Winchester'), ('Bill Bryson'), ('Tim Marshall'), ('Harm de Blij'), ('Jared Diamond'),
('Peter Frankopan'), ('Robert Kaplan'), ('Halford Mackinder'), ('Yi-Fu Tuan'), ('David Harvey'),
-- General/Multi-genre Authors
('Malcolm Gladwell'), ('Nassim Nicholas Taleb'), ('Daniel Kahneman'), ('Steven Pinker'), ('Noam Chomsky'),
('Umberto Eco'), ('Jorge Luis Borges'), ('Italo Calvino'), ('Isaac Asimov'), ('Arthur C. Clarke'),
('Philip K. Dick'), ('Ursula K. Le Guin'), ('Ray Bradbury'), ('Kurt Vonnegut'), ('George Orwell'),
('Aldous Huxley'), ('Margaret Atwood'), ('Salman Rushdie'), ('Gabriel Garcia Marquez'), ('Milan Kundera');


-- 3. Insert Books (150 books)


-- SCIENCE BOOKS (50 books)
INSERT INTO book (ISBN, title, pub_year, selling_price, category, pub_id) VALUES
('978-0-553-10953-5', 'A Brief History of Time', 1988, 18.99, 'Science', 1),
('978-0-345-53943-4', 'Cosmos', 1980, 22.50, 'Science', 1),
('978-0-618-91893-5', 'The Selfish Gene', 1976, 16.95, 'Science', 4),
('978-0-062-31609-7', 'Sapiens: A Brief History of Humankind', 2011, 24.99, 'Science', 2),
('978-1-416-56130-8', 'The Greatest Show on Earth', 2009, 19.99, 'Science', 3),
('978-0-385-51224-6', 'A Short History of Nearly Everything', 2003, 21.50, 'Science', 1),
('978-0-393-35198-8', 'The Elegant Universe', 1999, 25.99, 'Science', 16),
('978-0-385-50929-1', 'The Fabric of the Cosmos', 2004, 27.50, 'Science', 1),
('978-0-307-27836-3', 'The Grand Design', 2010, 23.00, 'Science', 1),
('978-1-594-20286-7', 'Astrophysics for People in a Hurry', 2017, 18.95, 'Science', 16),
('978-0-393-06918-1', 'Physics of the Impossible', 2008, 24.50, 'Science', 16),
('978-0-393-34664-7', 'The Big Picture', 2016, 26.99, 'Science', 16),
('978-0-060-93250-5', 'Seven Brief Lessons on Physics', 2014, 14.95, 'Science', 20),
('978-0-393-08542-6', 'Reality Is Not What It Seems', 2016, 22.00, 'Science', 16),
('978-0-316-34661-9', 'The Order of Time', 2017, 24.00, 'Science', 20),
('978-0-393-05755-3', 'The Mismeasure of Man', 1981, 19.99, 'Science', 16),
('978-0-674-97654-2', 'On Human Nature', 1978, 21.50, 'Science', 27),
('978-0-393-31542-0', 'The Double Helix', 1968, 16.95, 'Science', 16),
('978-0-465-06792-7', 'The Origin of Species', 1859, 18.00, 'Science', 8),
('978-0-691-17853-1', 'Relativity: The Special and General Theory', 1916, 15.99, 'Science', 22),
('978-0-465-02395-3', 'Surely You''re Joking, Mr. Feynman!', 1985, 17.99, 'Science', 8),
('978-0-465-07681-3', 'The First Three Minutes', 1977, 19.50, 'Science', 8),
('978-0-465-02094-5', 'The Road to Reality', 2004, 29.99, 'Science', 8),
('978-0-060-80606-9', 'Disturbing the Universe', 1979, 20.00, 'Science', 2),
('978-0-679-76867-8', 'The Demon-Haunted World', 1995, 23.50, 'Science', 1),
('978-0-062-31630-1', 'Homo Deus: A Brief History of Tomorrow', 2015, 26.99, 'Science', 2),
('978-0-385-53755-1', 'The Hidden Reality', 2011, 28.00, 'Science', 1),
('978-0-393-33882-6', 'Warped Passages', 2005, 24.95, 'Science', 16),
('978-0-307-45822-5', 'A Universe from Nothing', 2012, 22.99, 'Science', 1),
('978-0-385-35850-9', 'The God Particle', 1993, 21.00, 'Science', 1),
('978-0-465-02565-0', 'Quantum Theory Cannot Hurt You', 2007, 17.50, 'Science', 8),
('978-0-393-34257-1', 'The Particle at the End of the Universe', 2012, 23.99, 'Science', 16),
('978-0-393-93900-9', 'From Eternity to Here', 2010, 25.50, 'Science', 16),
('978-0-062-06296-7', 'The Beginning of Infinity', 2011, 26.00, 'Science', 2),
('978-0-393-05165-0', 'The Character of Physical Law', 1965, 16.99, 'Science', 16),
('978-0-060-95649-5', 'The Diversity of Life', 1992, 19.99, 'Science', 2),
('978-0-674-97698-6', 'Sociobiology', 1975, 32.00, 'Science', 27),
('978-0-393-30358-8', 'Wonderful Life', 1989, 20.50, 'Science', 16),
('978-0-393-31527-7', 'The Structure of Evolutionary Theory', 2002, 45.00, 'Science', 16),
('978-0-393-04092-0', 'The Ancestor''s Tale', 2004, 28.99, 'Science', 16),
('978-0-060-06129-8', 'The Blind Watchmaker', 1986, 17.95, 'Science', 2),
('978-0-393-31647-2', 'Climbing Mount Improbable', 1996, 18.50, 'Science', 16),
('978-0-618-00583-3', 'The Extended Phenotype', 1982, 24.00, 'Science', 4),
('978-0-618-05673-5', 'River Out of Eden', 1995, 16.50, 'Science', 4),
('978-0-547-34668-6', 'Unweaving the Rainbow', 1998, 19.95, 'Science', 4),
('978-0-393-02794-3', 'Life Itself', 1981, 22.50, 'Science', 16),
('978-0-062-23265-5', 'The Emperor''s New Mind', 1989, 26.99, 'Science', 2),
('978-0-393-03835-2', 'Godel, Escher, Bach', 1979, 29.95, 'Science', 16),
('978-0-465-09138-0', 'Chaos: Making a New Science', 1987, 18.99, 'Science', 8),
('978-0-465-02656-5', 'Complexity: The Emerging Science', 1992, 21.95, 'Science', 8);

-- ART BOOKS (30 books)
INSERT INTO book (ISBN, title, pub_year, selling_price, category, pub_id) VALUES
('978-0-714-86757-3', 'Leonardo da Vinci: The Complete Paintings', 2019, 45.00, 'Art', 6),
('978-3-836-56165-8', 'Van Gogh: The Complete Paintings', 2015, 50.00, 'Art', 4),
('978-0-870-70755-7', 'Picasso: Painting the Blue Period', 2018, 55.00, 'Art', 7),
('978-0-500-23954-5', 'The Story of Art', 2016, 39.95, 'Art', 6),
('978-1-419-70743-7', 'The Art Book', 2017, 29.95, 'Art', 5),
('978-0-500-20366-8', 'Ways of Seeing', 1972, 16.95, 'Art', 6),
('978-0-300-10616-9', 'Art and Illusion', 1960, 35.00, 'Art', 21),
('978-0-563-34562-9', 'Civilisation', 1969, 42.50, 'Art', 6),
('978-0-375-70527-1', 'The Power of Art', 2006, 38.99, 'Art', 1),
('978-0-307-26729-8', 'Nothing If Not Critical', 1990, 24.95, 'Art', 1),
('978-0-500-28247-7', 'Concerning the Spiritual in Art', 1911, 18.50, 'Art', 6),
('978-0-520-20054-9', 'The Letters of Vincent van Gogh', 1996, 22.00, 'Art', 7),
('978-0-87070-452-3', 'Picasso and Portraiture', 1996, 48.00, 'Art', 7),
('978-0-385-48018-8', 'The Agony and the Ecstasy', 1961, 19.99, 'Art', 1),
('978-0-307-27955-1', 'The Secret Lives of Color', 2016, 32.00, 'Art', 1),
('978-0-500-20376-7', 'The Lives of the Artists', 1550, 28.50, 'Art', 6),
('978-0-393-31662-5', 'Sister Wendy''s Story of Painting', 1994, 35.99, 'Art', 16),
('978-0-500-29306-0', 'Modern Art', 2000, 41.00, 'Art', 6),
('978-0-300-05331-8', 'Abstract Expressionism', 1990, 39.95, 'Art', 21),
('978-0-571-20558-8', 'Art Through the Ages', 2010, 68.00, 'Art', 18),
('978-0-500-20153-4', 'The Shock of the New', 1980, 33.50, 'Art', 6),
('978-0-300-09257-8', 'Renaissance Art', 2005, 45.00, 'Art', 21),
('978-0-500-23849-4', 'Baroque and Rococo', 1999, 37.50, 'Art', 6),
('978-0-714-83994-5', 'Impressionism', 2008, 34.95, 'Art', 6),
('978-0-500-20244-9', 'Post-Impressionism', 1979, 31.00, 'Art', 6),
('978-0-300-10623-7', 'Cubism', 2002, 42.00, 'Art', 21),
('978-0-500-20401-6', 'Surrealism', 2004, 36.99, 'Art', 6),
('978-0-714-84729-2', 'Pop Art', 1997, 29.95, 'Art', 6),
('978-0-500-20377-4', 'Minimalism', 2000, 32.50, 'Art', 6),
('978-0-300-12244-2', 'Contemporary Art: A Very Short Introduction', 2006, 12.95, 'Art', 21);

-- RELIGION BOOKS (30 books)
INSERT INTO book (ISBN, title, pub_year, selling_price, category, pub_id) VALUES
('978-0-385-72117-0', 'A History of God', 1993, 17.99, 'Religion', 1),
('978-0-812-98407-5', 'Zealot: The Life and Times of Jesus', 2013, 18.00, 'Religion', 1),
('978-0-143-12820-3', 'The Art of Happiness', 1998, 15.95, 'Religion', 3),
('978-0-679-72856-7', 'The World''s Religions', 1991, 19.99, 'Religion', 2),
('978-0-060-65542-7', 'The Case for God', 2009, 16.99, 'Religion', 2),
('978-0-385-50996-3', 'Fields of Blood: Religion and History of Violence', 2014, 21.50, 'Religion', 1),
('978-0-385-72122-4', 'The Great Transformation', 2006, 20.00, 'Religion', 1),
('978-0-812-97214-0', 'No god but God', 2005, 17.50, 'Religion', 1),
('978-0-060-95387-6', 'God: A Human History', 2017, 19.95, 'Religion', 2),
('978-0-060-69996-8', 'The Gnostic Gospels', 1979, 16.00, 'Religion', 2),
('978-0-679-64090-5', 'Peace Is Every Step', 1991, 14.95, 'Religion', 1),
('978-0-062-02400-6', 'Living Buddha, Living Christ', 1995, 16.50, 'Religion', 2),
('978-0-060-92990-1', 'The Seven Storey Mountain', 1948, 18.99, 'Religion', 2),
('978-0-062-56554-9', 'New Seeds of Contemplation', 1961, 15.99, 'Religion', 2),
('978-0-060-65293-8', 'Mere Christianity', 1952, 16.99, 'Religion', 2),
('978-0-062-02954-4', 'The Screwtape Letters', 1942, 14.50, 'Religion', 2),
('978-0-385-49373-7', 'The Name of God is Mercy', 2016, 17.00, 'Religion', 1),
('978-0-385-51037-2', 'God Has a Dream', 2004, 15.50, 'Religion', 1),
('978-0-060-60857-8', 'The Essential Huston Smith', 2000, 22.50, 'Religion', 2),
('978-0-060-65518-2', 'The Soul of Christianity', 2005, 18.99, 'Religion', 2),
('978-0-679-42817-2', 'The Hero with a Thousand Faces', 1949, 24.99, 'Religion', 1),
('978-0-691-01762-0', 'The Power of Myth', 1988, 21.95, 'Religion', 22),
('978-0-691-01786-6', 'The Sacred and the Profane', 1957, 19.50, 'Religion', 22),
('978-0-060-62558-2', 'I and Thou', 1923, 16.95, 'Religion', 2),
('978-0-226-80337-8', 'Dynamics of Faith', 1957, 15.99, 'Religion', 24),
('978-0-385-19081-1', 'On Being a Christian', 1976, 23.50, 'Religion', 1),
('978-0-060-67257-2', 'Islam: A Short History', 2000, 14.99, 'Religion', 2),
('978-0-385-49556-4', 'Muhammad: A Prophet for Our Time', 2006, 16.50, 'Religion', 1),
('978-0-060-65548-9', 'Buddha', 2001, 17.95, 'Religion', 2),
('978-0-143-03834-6', 'The Bhagavad Gita', 2000, 13.95, 'Religion', 3);

-- HISTORY BOOKS (30 books)
INSERT INTO book (ISBN, title, pub_year, selling_price, category, pub_id) VALUES
('978-0-060-52837-9', 'A People''s History of the United States', 1980, 20.00, 'History', 2),
('978-0-393-35398-2', 'Guns, Germs, and Steel', 1997, 22.95, 'History', 8),
('978-0-141-98978-7', 'SPQR: A History of Ancient Rome', 2015, 19.99, 'History', 6),
('978-0-385-49081-1', '1491: New Revelations of the Americas', 2005, 18.50, 'History', 1),
('978-0-679-64159-9', 'The Age of Extremes', 1994, 24.99, 'History', 1),
('978-0-375-40360-3', 'Postwar: A History of Europe', 2005, 26.00, 'History', 1),
('978-0-375-72641-2', '1776', 2005, 18.99, 'History', 1),
('978-0-684-82491-8', 'John Adams', 2001, 21.50, 'History', 3),
('978-0-743-22247-5', 'Team of Rivals', 2005, 23.99, 'History', 3),
('978-0-393-08095-7', 'The Guns of August', 1962, 20.50, 'History', 16),
('978-0-679-64076-9', 'A Distant Mirror', 1978, 22.00, 'History', 1),
('978-0-679-72869-7', 'Citizens: A Chronicle of the French Revolution', 1989, 25.50, 'History', 1),
('978-0-349-11535-4', 'Confronting the Classics', 2013, 17.95, 'History', 13),
('978-0-393-24027-0', 'Rubicon: The Last Years of the Roman Republic', 2003, 19.50, 'History', 16),
('978-0-385-53515-1', 'Hitler: A Biography', 1999, 28.99, 'History', 1),
('978-0-375-41413-5', 'The Third Reich at War', 2008, 26.50, 'History', 1),
('978-0-385-33070-3', 'Bloodlands: Europe Between Hitler and Stalin', 2010, 24.95, 'History', 1),
('978-0-679-64226-8', 'The Peacemakers', 2001, 23.50, 'History', 1),
('978-0-465-00802-8', 'The Second World War', 2011, 27.99, 'History', 8),
('978-0-375-50483-5', 'Inferno: The World at War', 2011, 25.00, 'History', 1),
('978-0-465-02047-1', 'Empire: The Rise and Fall', 2002, 21.99, 'History', 8),
('978-0-385-51217-8', 'Civilization: The West and the Rest', 2011, 22.50, 'History', 1),
('978-0-674-02800-3', 'The Cold War', 2005, 19.95, 'History', 27),
('978-0-375-70372-7', 'Stalin: The Court of the Red Tsar', 2003, 24.00, 'History', 1),
('978-0-375-40376-4', 'Natasha''s Dance', 2002, 26.99, 'History', 1),
('978-0-385-51290-1', 'Gulag: A History', 2003, 23.50, 'History', 1),
('978-0-385-50356-5', 'Iron Curtain', 2012, 21.95, 'History', 1),
('978-0-393-34655-5', 'Sapiens: A Graphic History', 2020, 29.99, 'History', 16),
('978-0-062-46498-8', '21 Lessons for the 21st Century', 2018, 20.99, 'History', 2),
('978-0-393-60988-1', 'The Warmth of Other Suns', 2010, 18.50, 'History', 16);

-- GEOGRAPHY BOOKS (10 books)
INSERT INTO book (ISBN, title, pub_year, selling_price, category, pub_id) VALUES
('978-0-062-07312-1', 'The Map That Changed the World', 2001, 17.95, 'Geography', 2),
('978-0-307-26360-4', 'The Lost City of Z', 2009, 16.99, 'Geography', 1),
('978-1-426-21736-3', 'National Geographic Atlas of the World', 2019, 150.00, 'Geography', 9),
('978-0-374-53271-0', 'Prisoners of Geography', 2015, 18.99, 'Geography', 3),
('978-0-691-16973-7', 'Why Geography Matters', 2012, 21.99, 'Geography', 8),
('978-0-062-73468-0', 'The Revenge of Geography', 2012, 19.95, 'Geography', 2),
('978-1-408-86606-5', 'The Silk Roads', 2015, 24.99, 'Geography', 13),
('978-0-062-41698-5', 'The Power of Geography', 2021, 22.50, 'Geography', 2),
('978-0-679-64250-3', 'Collapse: How Societies Choose to Fail', 2005, 23.95, 'Geography', 1),
('978-0-691-14867-1', 'The World Until Yesterday', 2012, 20.99, 'Geography', 22);

COMMIT;


-- 4. Link Books to Authors (written_by)

INSERT INTO written_by (ISBN, author_id) VALUES
-- Science books authors
('978-0-553-10953-5', 1), ('978-0-345-53943-4', 2), ('978-0-618-91893-5', 3),
('978-0-062-31609-7', 46), ('978-1-416-56130-8', 3), ('978-0-385-51224-6', 72),
('978-0-393-35198-8', 5), ('978-0-385-50929-1', 5), ('978-0-307-27836-3', 1),
('978-1-594-20286-7', 4), ('978-0-393-06918-1', 6), ('978-0-393-34664-7', 7),
('978-0-060-93250-5', 10), ('978-0-393-08542-6', 10), ('978-0-316-34661-9', 10),
('978-0-393-05755-3', 11), ('978-0-674-97654-2', 12), ('978-0-393-31542-0', 13),
('978-0-465-06792-7', 15), ('978-0-691-17853-1', 16), ('978-0-465-02395-3', 17),
('978-0-465-07681-3', 18), ('978-0-465-02094-5', 19), ('978-0-060-80606-9', 20),
('978-0-679-76867-8', 2), ('978-0-062-31630-1', 46), ('978-0-385-53755-1', 5),
('978-0-393-33882-6', 8), ('978-0-307-45822-5', 9), ('978-0-385-35850-9', 10),
('978-0-465-02565-0', 7), ('978-0-393-34257-1', 7), ('978-0-393-93900-9', 7),
('978-0-062-06296-7', 4), ('978-0-393-05165-0', 17), ('978-0-060-95649-5', 12),
('978-0-674-97698-6', 12), ('978-0-393-30358-8', 11), ('978-0-393-31527-7', 11),
('978-0-393-04092-0', 3), ('978-0-060-06129-8', 3), ('978-0-393-31647-2', 3),
('978-0-618-00583-3', 3), ('978-0-618-05673-5', 3), ('978-0-547-34668-6', 3),
('978-0-393-02794-3', 14), ('978-0-062-23265-5', 19), ('978-0-393-03835-2', 20),
('978-0-465-09138-0', 18), ('978-0-465-02656-5', 19),

-- Art books authors
('978-0-714-86757-3', 21), ('978-3-836-56165-8', 23), ('978-0-870-70755-7', 24),
('978-0-500-23954-5', 26), ('978-1-419-70743-7', 26), ('978-0-500-20366-8', 27),
('978-0-300-10616-9', 26), ('978-0-563-34562-9', 28), ('978-0-375-70527-1', 30),
('978-0-307-26729-8', 29), ('978-0-500-28247-7', 31), ('978-0-520-20054-9', 23),
('978-0-87070-452-3', 24), ('978-0-385-48018-8', 21), ('978-0-307-27955-1', 26),
('978-0-500-20376-7', 21), ('978-0-393-31662-5', 28), ('978-0-500-29306-0', 26),
('978-0-300-05331-8', 26), ('978-0-571-20558-8', 26), ('978-0-500-20153-4', 29),
('978-0-300-09257-8', 26), ('978-0-500-23849-4', 26), ('978-0-714-83994-5', 33),
('978-0-500-20244-9', 32), ('978-0-300-10623-7', 24), ('978-0-500-20401-6', 25),
('978-0-714-84729-2', 26), ('978-0-500-20377-4', 26), ('978-0-300-12244-2', 26),

-- Religion books authors
('978-0-385-72117-0', 36), ('978-0-812-98407-5', 37), ('978-0-143-12820-3', 38),
('978-0-679-72856-7', 36), ('978-0-060-65542-7', 36), ('978-0-385-50996-3', 36),
('978-0-385-72122-4', 36), ('978-0-812-97214-0', 37), ('978-0-060-95387-6', 37),
('978-0-060-69996-8', 45), ('978-0-679-64090-5', 39), ('978-0-062-02400-6', 39),
('978-0-060-92990-1', 40), ('978-0-062-56554-9', 40), ('978-0-060-65293-8', 41),
('978-0-062-02954-4', 41), ('978-0-385-49373-7', 42), ('978-0-385-51037-2', 43),
('978-0-060-60857-8', 44), ('978-0-060-65518-2', 44), ('978-0-679-42817-2', 46),
('978-0-691-01762-0', 46), ('978-0-691-01786-6', 47), ('978-0-060-62558-2', 48),
('978-0-226-80337-8', 49), ('978-0-385-19081-1', 50), ('978-0-060-67257-2', 36),
('978-0-385-49556-4', 36), ('978-0-060-65548-9', 36), ('978-0-143-03834-6', 38),

-- History books authors
('978-0-060-52837-9', 53), ('978-0-393-35398-2', 47), ('978-0-141-98978-7', 59),
('978-0-385-49081-1', 47), ('978-0-679-64159-9', 54), ('978-0-375-40360-3', 62),
('978-0-375-72641-2', 56), ('978-0-684-82491-8', 56), ('978-0-743-22247-5', 57),
('978-0-393-08095-7', 55), ('978-0-679-64076-9', 55), ('978-0-679-72869-7', 58),
('978-0-349-11535-4', 59), ('978-0-393-24027-0', 60), ('978-0-385-53515-1', 61),
('978-0-375-41413-5', 61), ('978-0-385-33070-3', 62), ('978-0-679-64226-8', 63),
('978-0-465-00802-8', 64), ('978-0-375-50483-5', 65), ('978-0-465-02047-1', 66),
('978-0-385-51217-8', 66), ('978-0-674-02800-3', 68), ('978-0-375-70372-7', 68),
('978-0-375-40376-4', 69), ('978-0-385-51290-1', 70), ('978-0-385-50356-5', 70),
('978-0-393-34655-5', 51), ('978-0-062-46498-8', 51), ('978-0-393-60988-1', 57),

-- Geography books authors
('978-0-062-07312-1', 71), ('978-0-307-26360-4', 72), ('978-1-426-21736-3', 72),
('978-0-374-53271-0', 73), ('978-0-691-16973-7', 74), ('978-0-062-73468-0', 73),
('978-1-408-86606-5', 76), ('978-0-062-41698-5', 73), ('978-0-679-64250-3', 52),
('978-0-691-14867-1', 52);

COMMIT;


-- 5. Update Stock for All Books

UPDATE stock SET quantity = 85, threshold = 20 WHERE ISBN = '978-0-553-10953-5';
UPDATE stock SET quantity = 72, threshold = 15 WHERE ISBN = '978-0-345-53943-4';
UPDATE stock SET quantity = 95, threshold = 25 WHERE ISBN = '978-0-618-91893-5';
UPDATE stock SET quantity = 12, threshold = 20 WHERE ISBN = '978-0-062-31609-7';
UPDATE stock SET quantity = 68, threshold = 18 WHERE ISBN = '978-1-416-56130-8';
UPDATE stock SET quantity = 77, threshold = 15 WHERE ISBN = '978-0-385-51224-6';
UPDATE stock SET quantity = 54, threshold = 12 WHERE ISBN = '978-0-393-35198-8';
UPDATE stock SET quantity = 61, threshold = 15 WHERE ISBN = '978-0-385-50929-1';
UPDATE stock SET quantity = 43, threshold = 10 WHERE ISBN = '978-0-307-27836-3';
UPDATE stock SET quantity = 89, threshold = 22 WHERE ISBN = '978-1-594-20286-7';
UPDATE stock SET quantity = 36, threshold = 10 WHERE ISBN = '978-0-393-06918-1';
UPDATE stock SET quantity = 58, threshold = 14 WHERE ISBN = '978-0-393-34664-7';
UPDATE stock SET quantity = 91, threshold = 20 WHERE ISBN = '978-0-060-93250-5';
UPDATE stock SET quantity = 47, threshold = 12 WHERE ISBN = '978-0-393-08542-6';
UPDATE stock SET quantity = 52, threshold = 13 WHERE ISBN = '978-0-316-34661-9';
UPDATE stock SET quantity = 65, threshold = 16 WHERE ISBN = '978-0-393-05755-3';
UPDATE stock SET quantity = 71, threshold = 18 WHERE ISBN = '978-0-674-97654-2';
UPDATE stock SET quantity = 39, threshold = 10 WHERE ISBN = '978-0-393-31542-0';
UPDATE stock SET quantity = 83, threshold = 20 WHERE ISBN = '978-0-465-06792-7';
UPDATE stock SET quantity = 44, threshold = 11 WHERE ISBN = '978-0-691-17853-1';
UPDATE stock SET quantity = 76, threshold = 19 WHERE ISBN = '978-0-465-02395-3';
UPDATE stock SET quantity = 33, threshold = 8 WHERE ISBN = '978-0-465-07681-3';
UPDATE stock SET quantity = 28, threshold = 7 WHERE ISBN = '978-0-465-02094-5';
UPDATE stock SET quantity = 62, threshold = 15 WHERE ISBN = '978-0-060-80606-9';
UPDATE stock SET quantity = 8, threshold = 18 WHERE ISBN = '978-0-679-76867-8';
UPDATE stock SET quantity = 55, threshold = 14 WHERE ISBN = '978-0-062-31630-1';
UPDATE stock SET quantity = 41, threshold = 10 WHERE ISBN = '978-0-385-53755-1';
UPDATE stock SET quantity = 67, threshold = 17 WHERE ISBN = '978-0-393-33882-6';
UPDATE stock SET quantity = 48, threshold = 12 WHERE ISBN = '978-0-307-45822-5';
UPDATE stock SET quantity = 74, threshold = 18 WHERE ISBN = '978-0-385-35850-9';
UPDATE stock SET quantity = 56, threshold = 14 WHERE ISBN = '978-0-465-02565-0';
UPDATE stock SET quantity = 82, threshold = 20 WHERE ISBN = '978-0-393-34257-1';
UPDATE stock SET quantity = 38, threshold = 9 WHERE ISBN = '978-0-393-93900-9';
UPDATE stock SET quantity = 69, threshold = 17 WHERE ISBN = '978-0-062-06296-7';
UPDATE stock SET quantity = 51, threshold = 13 WHERE ISBN = '978-0-393-05165-0';
UPDATE stock SET quantity = 45, threshold = 11 WHERE ISBN = '978-0-060-95649-5';
UPDATE stock SET quantity = 27, threshold = 7 WHERE ISBN = '978-0-674-97698-6';
UPDATE stock SET quantity = 63, threshold = 16 WHERE ISBN = '978-0-393-30358-8';
UPDATE stock SET quantity = 31, threshold = 8 WHERE ISBN = '978-0-393-31527-7';
UPDATE stock SET quantity = 73, threshold = 18 WHERE ISBN = '978-0-393-04092-0';
UPDATE stock SET quantity = 59, threshold = 15 WHERE ISBN = '978-0-060-06129-8';
UPDATE stock SET quantity = 42, threshold = 10 WHERE ISBN = '978-0-393-31647-2';
UPDATE stock SET quantity = 37, threshold = 9 WHERE ISBN = '978-0-618-00583-3';
UPDATE stock SET quantity = 66, threshold = 16 WHERE ISBN = '978-0-618-05673-5';
UPDATE stock SET quantity = 53, threshold = 13 WHERE ISBN = '978-0-547-34668-6';
UPDATE stock SET quantity = 29, threshold = 7 WHERE ISBN = '978-0-393-02794-3';
UPDATE stock SET quantity = 46, threshold = 11 WHERE ISBN = '978-0-062-23265-5';
UPDATE stock SET quantity = 34, threshold = 8 WHERE ISBN = '978-0-393-03835-2';
UPDATE stock SET quantity = 70, threshold = 17 WHERE ISBN = '978-0-465-09138-0';
UPDATE stock SET quantity = 49, threshold = 12 WHERE ISBN = '978-0-465-02656-5';

-- Art books stock
UPDATE stock SET quantity = 24, threshold = 6 WHERE ISBN = '978-0-714-86757-3';
UPDATE stock SET quantity = 19, threshold = 5 WHERE ISBN = '978-3-836-56165-8';
UPDATE stock SET quantity = 15, threshold = 4 WHERE ISBN = '978-0-870-70755-7';
UPDATE stock SET quantity = 42, threshold = 10 WHERE ISBN = '978-0-500-23954-5';
UPDATE stock SET quantity = 38, threshold = 9 WHERE ISBN = '978-1-419-70743-7';
UPDATE stock SET quantity = 67, threshold = 16 WHERE ISBN = '978-0-500-20366-8';
UPDATE stock SET quantity = 28, threshold = 7 WHERE ISBN = '978-0-300-10616-9';
UPDATE stock SET quantity = 31, threshold = 8 WHERE ISBN = '978-0-563-34562-9';
UPDATE stock SET quantity = 36, threshold = 9 WHERE ISBN = '978-0-375-70527-1';
UPDATE stock SET quantity = 44, threshold = 11 WHERE ISBN = '978-0-307-26729-8';
UPDATE stock SET quantity = 51, threshold = 13 WHERE ISBN = '978-0-500-28247-7';
UPDATE stock SET quantity = 39, threshold = 10 WHERE ISBN = '978-0-520-20054-9';
UPDATE stock SET quantity = 22, threshold = 6 WHERE ISBN = '978-0-87070-452-3';
UPDATE stock SET quantity = 47, threshold = 12 WHERE ISBN = '978-0-385-48018-8';
UPDATE stock SET quantity = 33, threshold = 8 WHERE ISBN = '978-0-307-27955-1';
UPDATE stock SET quantity = 41, threshold = 10 WHERE ISBN = '978-0-500-20376-7';
UPDATE stock SET quantity = 35, threshold = 9 WHERE ISBN = '978-0-393-31662-5';
UPDATE stock SET quantity = 29, threshold = 7 WHERE ISBN = '978-0-500-29306-0';
UPDATE stock SET quantity = 26, threshold = 7 WHERE ISBN = '978-0-300-05331-8';
UPDATE stock SET quantity = 18, threshold = 5 WHERE ISBN = '978-0-571-20558-8';
UPDATE stock SET quantity = 43, threshold = 11 WHERE ISBN = '978-0-500-20153-4';
UPDATE stock SET quantity = 25, threshold = 6 WHERE ISBN = '978-0-300-09257-8';
UPDATE stock SET quantity = 32, threshold = 8 WHERE ISBN = '978-0-500-23849-4';
UPDATE stock SET quantity = 37, threshold = 9 WHERE ISBN = '978-0-714-83994-5';
UPDATE stock SET quantity = 40, threshold = 10 WHERE ISBN = '978-0-500-20244-9';
UPDATE stock SET quantity = 27, threshold = 7 WHERE ISBN = '978-0-300-10623-7';
UPDATE stock SET quantity = 34, threshold = 8 WHERE ISBN = '978-0-500-20401-6';
UPDATE stock SET quantity = 48, threshold = 12 WHERE ISBN = '978-0-714-84729-2';
UPDATE stock SET quantity = 45, threshold = 11 WHERE ISBN = '978-0-500-20377-4';
UPDATE stock SET quantity = 88, threshold = 20 WHERE ISBN = '978-0-300-12244-2';

-- Religion books stock
UPDATE stock SET quantity = 72, threshold = 18 WHERE ISBN = '978-0-385-72117-0';
UPDATE stock SET quantity = 64, threshold = 16 WHERE ISBN = '978-0-812-98407-5';
UPDATE stock SET quantity = 91, threshold = 22 WHERE ISBN = '978-0-143-12820-3';
UPDATE stock SET quantity = 58, threshold = 14 WHERE ISBN = '978-0-679-72856-7';
UPDATE stock SET quantity = 53, threshold = 13 WHERE ISBN = '978-0-060-65542-7';
UPDATE stock SET quantity = 46, threshold = 11 WHERE ISBN = '978-0-385-50996-3';
UPDATE stock SET quantity = 51, threshold = 13 WHERE ISBN = '978-0-385-72122-4';
UPDATE stock SET quantity = 67, threshold = 17 WHERE ISBN = '978-0-812-97214-0';
UPDATE stock SET quantity = 41, threshold = 10 WHERE ISBN = '978-0-060-95387-6';
UPDATE stock SET quantity = 75, threshold = 19 WHERE ISBN = '978-0-060-69996-8';
UPDATE stock SET quantity = 83, threshold = 20 WHERE ISBN = '978-0-679-64090-5';
UPDATE stock SET quantity = 69, threshold = 17 WHERE ISBN = '978-0-062-02400-6';
UPDATE stock SET quantity = 54, threshold = 14 WHERE ISBN = '978-0-060-92990-1';
UPDATE stock SET quantity = 47, threshold = 12 WHERE ISBN = '978-0-062-56554-9';
UPDATE stock SET quantity = 86, threshold = 21 WHERE ISBN = '978-0-060-65293-8';
UPDATE stock SET quantity = 92, threshold = 23 WHERE ISBN = '978-0-062-02954-4';
UPDATE stock SET quantity = 61, threshold = 15 WHERE ISBN = '978-0-385-49373-7';
UPDATE stock SET quantity = 57, threshold = 14 WHERE ISBN = '978-0-385-51037-2';
UPDATE stock SET quantity = 44, threshold = 11 WHERE ISBN = '978-0-060-60857-8';
UPDATE stock SET quantity = 49, threshold = 12 WHERE ISBN = '978-0-060-65518-2';
UPDATE stock SET quantity = 38, threshold = 9 WHERE ISBN = '978-0-679-42817-2';
UPDATE stock SET quantity = 55, threshold = 14 WHERE ISBN = '978-0-691-01762-0';
UPDATE stock SET quantity = 42, threshold = 10 WHERE ISBN = '978-0-691-01786-6';
UPDATE stock SET quantity = 63, threshold = 16 WHERE ISBN = '978-0-060-62558-2';
UPDATE stock SET quantity = 71, threshold = 18 WHERE ISBN = '978-0-226-80337-8';
UPDATE stock SET quantity = 35, threshold = 9 WHERE ISBN = '978-0-385-19081-1';
UPDATE stock SET quantity = 78, threshold = 19 WHERE ISBN = '978-0-060-67257-2';
UPDATE stock SET quantity = 66, threshold = 16 WHERE ISBN = '978-0-385-49556-4';
UPDATE stock SET quantity = 59, threshold = 15 WHERE ISBN = '978-0-060-65548-9';
UPDATE stock SET quantity = 94, threshold = 23 WHERE ISBN = '978-0-143-03834-6';

-- History books stock  
UPDATE stock SET quantity = 76, threshold = 19 WHERE ISBN = '978-0-060-52837-9';
UPDATE stock SET quantity = 82, threshold = 20 WHERE ISBN = '978-0-393-35398-2';
UPDATE stock SET quantity = 68, threshold = 17 WHERE ISBN = '978-0-141-98978-7';
UPDATE stock SET quantity = 54, threshold = 14 WHERE ISBN = '978-0-385-49081-1';
UPDATE stock SET quantity = 41, threshold = 10 WHERE ISBN = '978-0-679-64159-9';
UPDATE stock SET quantity = 37, threshold = 9 WHERE ISBN = '978-0-375-40360-3';
UPDATE stock SET quantity = 85, threshold = 21 WHERE ISBN = '978-0-375-72641-2';
UPDATE stock SET quantity = 71, threshold = 18 WHERE ISBN = '978-0-684-82491-8';
UPDATE stock SET quantity = 63, threshold = 16 WHERE ISBN = '978-0-743-22247-5';
UPDATE stock SET quantity = 49, threshold = 12 WHERE ISBN = '978-0-393-08095-7';
UPDATE stock SET quantity = 56, threshold = 14 WHERE ISBN = '978-0-679-64076-9';
UPDATE stock SET quantity = 44, threshold = 11 WHERE ISBN = '978-0-679-72869-7';
UPDATE stock SET quantity = 79, threshold = 20 WHERE ISBN = '978-0-349-11535-4';
UPDATE stock SET quantity = 67, threshold = 17 WHERE ISBN = '978-0-393-24027-0';
UPDATE stock SET quantity = 32, threshold = 8 WHERE ISBN = '978-0-385-53515-1';
UPDATE stock SET quantity = 28, threshold = 7 WHERE ISBN = '978-0-375-41413-5';
UPDATE stock SET quantity = 51, threshold = 13 WHERE ISBN = '978-0-385-33070-3';
UPDATE stock SET quantity = 46, threshold = 12 WHERE ISBN = '978-0-679-64226-8';
UPDATE stock SET quantity = 39, threshold = 10 WHERE ISBN = '978-0-465-00802-8';
UPDATE stock SET quantity = 43, threshold = 11 WHERE ISBN = '978-0-375-50483-5';
UPDATE stock SET quantity = 58, threshold = 15 WHERE ISBN = '978-0-465-02047-1';
UPDATE stock SET quantity = 64, threshold = 16 WHERE ISBN = '978-0-385-51217-8';
UPDATE stock SET quantity = 52, threshold = 13 WHERE ISBN = '978-0-674-02800-3';
UPDATE stock SET quantity = 35, threshold = 9 WHERE ISBN = '978-0-375-70372-7';
UPDATE stock SET quantity = 41, threshold = 10 WHERE ISBN = '978-0-375-40376-4';
UPDATE stock SET quantity = 47, threshold = 12 WHERE ISBN = '978-0-385-51290-1';
UPDATE stock SET quantity = 54, threshold = 14 WHERE ISBN = '978-0-385-50356-5';
UPDATE stock SET quantity = 7, threshold = 15 WHERE ISBN = '978-0-393-34655-5';
UPDATE stock SET quantity = 88, threshold = 22 WHERE ISBN = '978-0-062-46498-8';
UPDATE stock SET quantity = 73, threshold = 18 WHERE ISBN = '978-0-393-60988-1';

-- Geography books stock
UPDATE stock SET quantity = 59, threshold = 15 WHERE ISBN = '978-0-062-07312-1';
UPDATE stock SET quantity = 66, threshold = 16 WHERE ISBN = '978-0-307-26360-4';
UPDATE stock SET quantity = 12, threshold = 3 WHERE ISBN = '978-1-426-21736-3';
UPDATE stock SET quantity = 9, threshold = 18 WHERE ISBN = '978-0-374-53271-0';
UPDATE stock SET quantity = 47, threshold = 12 WHERE ISBN = '978-0-691-16973-7';
UPDATE stock SET quantity = 52, threshold = 13 WHERE ISBN = '978-0-062-73468-0';
UPDATE stock SET quantity = 71, threshold = 18 WHERE ISBN = '978-1-408-86606-5';
UPDATE stock SET quantity = 64, threshold = 16 WHERE ISBN = '978-0-062-41698-5';
UPDATE stock SET quantity = 38, threshold = 10 WHERE ISBN = '978-0-679-64250-3';
UPDATE stock SET quantity = 56, threshold = 14 WHERE ISBN = '978-0-691-14867-1';

COMMIT;


-- 6. Insert Customers (50 customers)

INSERT INTO customer (username, password, fname, lname, email, phone, address) VALUES
('john_doe', 'pass123', 'John', 'Doe', 'john.doe@email.com', '+1-555-0101', '123 Main St, New York, NY 10001'),
('jane_smith', 'pass123', 'Jane', 'Smith', 'jane.smith@email.com', '+1-555-0102', '456 Oak Ave, Los Angeles, CA 90001'),
('bob_jones', 'pass123', 'Bob', 'Jones', 'bob.jones@email.com', '+1-555-0103', '789 Pine Rd, Chicago, IL 60601'),
('alice_wilson', 'pass123', 'Alice', 'Wilson', 'alice.wilson@email.com', '+1-555-0104', '321 Elm St, Houston, TX 77001'),
('charlie_brown', 'pass123', 'Charlie', 'Brown', 'charlie.brown@email.com', '+1-555-0105', '654 Maple Dr, Phoenix, AZ 85001'),
('diana_prince', 'pass123', 'Diana', 'Prince', 'diana.prince@email.com', '+1-555-0106', '987 Cedar Ln, Philadelphia, PA 19101'),
('evan_garcia', 'pass123', 'Evan', 'Garcia', 'evan.garcia@email.com', '+1-555-0107', '147 Birch Blvd, San Antonio, TX 78201'),
('fiona_lee', 'pass123', 'Fiona', 'Lee', 'fiona.lee@email.com', '+1-555-0108', '258 Spruce St, San Diego, CA 92101'),
('george_martin', 'pass123', 'George', 'Martin', 'george.martin@email.com', '+1-555-0109', '369 Willow Way, Dallas, TX 75201'),
('hannah_davis', 'pass123', 'Hannah', 'Davis', 'hannah.davis@email.com', '+1-555-0110', '741 Aspen Ct, San Jose, CA 95101'),
('ian_taylor', 'pass123', 'Ian', 'Taylor', 'ian.taylor@email.com', '+1-555-0111', '852 Poplar St, Austin, TX 78701'),
('julia_moore', 'pass123', 'Julia', 'Moore', 'julia.moore@email.com', '+1-555-0112', '963 Walnut Ave, Jacksonville, FL 32099'),
('kevin_white', 'pass123', 'Kevin', 'White', 'kevin.white@email.com', '+1-555-0113', '159 Cherry Ln, San Francisco, CA 94102'),
('laura_harris', 'pass123', 'Laura', 'Harris', 'laura.harris@email.com', '+1-555-0114', '357 Hickory Dr, Columbus, OH 43004'),
('michael_clark', 'pass123', 'Michael', 'Clark', 'michael.clark@email.com', '+1-555-0115', '468 Sycamore Rd, Indianapolis, IN 46201'),
('nancy_lewis', 'pass123', 'Nancy', 'Lewis', 'nancy.lewis@email.com', '+1-555-0116', '579 Dogwood Ct, Seattle, WA 98101'),
('oliver_walker', 'pass123', 'Oliver', 'Walker', 'oliver.walker@email.com', '+1-555-0117', '681 Redwood Way, Denver, CO 80201'),
('patricia_hall', 'pass123', 'Patricia', 'Hall', 'patricia.hall@email.com', '+1-555-0118', '792 Magnolia Blvd, Boston, MA 02101'),
('quinn_allen', 'pass123', 'Quinn', 'Allen', 'quinn.allen@email.com', '+1-555-0119', '814 Cypress Ave, Nashville, TN 37201'),
('rachel_young', 'pass123', 'Rachel', 'Young', 'rachel.young@email.com', '+1-555-0120', '925 Juniper St, Detroit, MI 48201'),
('samuel_king', 'pass123', 'Samuel', 'King', 'samuel.king@email.com', '+1-555-0121', '136 Fir Ln, Portland, OR 97201'),
('tina_wright', 'pass123', 'Tina', 'Wright', 'tina.wright@email.com', '+1-555-0122', '247 Alder Dr, Las Vegas, NV 89101'),
('umar_lopez', 'pass123', 'Umar', 'Lopez', 'umar.lopez@email.com', '+1-555-0123', '358 Beech Rd, Memphis, TN 38101'),
('victoria_hill', 'pass123', 'Victoria', 'Hill', 'victoria.hill@email.com', '+1-555-0124', '469 Ash Ct, Louisville, KY 40201'),
('william_scott', 'pass123', 'William', 'Scott', 'william.scott@email.com', '+1-555-0125', '571 Palm Way, Baltimore, MD 21201'),
('xena_green', 'pass123', 'Xena', 'Green', 'xena.green@email.com', '+1-555-0126', '682 Laurel Blvd, Milwaukee, WI 53201'),
('yuki_adams', 'pass123', 'Yuki', 'Adams', 'yuki.adams@email.com', '+1-555-0127', '793 Hazel Ave, Albuquerque, NM 87101'),
('zachary_baker', 'pass123', 'Zachary', 'Baker', 'zachary.baker@email.com', '+1-555-0128', '815 Pecan St, Tucson, AZ 85701'),
('amy_nelson', 'pass123', 'Amy', 'Nelson', 'amy.nelson@email.com', '+1-555-0129', '926 Chestnut Ln, Fresno, CA 93701'),
('brian_carter', 'pass123', 'Brian', 'Carter', 'brian.carter@email.com', '+1-555-0130', '137 Linden Dr, Sacramento, CA 95801'),
('carol_mitchell', 'pass123', 'Carol', 'Mitchell', 'carol.mitchell@email.com', '+1-555-0131', '248 Elm wood Rd, Long Beach, CA 90801'),
('david_perez', 'pass123', 'David', 'Perez', 'david.perez@email.com', '+1-555-0132', '359 Birchwood Ct, Kansas City, MO 64101'),
('emma_roberts', 'pass123', 'Emma', 'Roberts', 'emma.roberts@email.com', '+1-555-0133', '461 Oakmont Way, Mesa, AZ 85201'),
('frank_turner', 'pass123', 'Frank', 'Turner', 'frank.turner@email.com', '+1-555-0134', '572 Pinehurst Blvd, Atlanta, GA 30301'),
('grace_phillips', 'pass123', 'Grace', 'Phillips', 'grace.phillips@email.com', '+1-555-0135', '683 Maplewood Ave, Colorado Springs, CO 80901'),
('henry_campbell', 'pass123', 'Henry', 'Campbell', 'henry.campbell@email.com', '+1-555-0136', '794 Cedarbrook St, Raleigh, NC 27601'),
('iris_parker', 'pass123', 'Iris', 'Parker', 'iris.parker@email.com', '+1-555-0137', '816 Willowbrook Ln, Miami, FL 33101'),
('jack_evans', 'pass123', 'Jack', 'Evans', 'jack.evans@email.com', '+1-555-0138', '927 Riverside Dr, Oakland, CA 94601'),
('kelly_edwards', 'pass123', 'Kelly', 'Edwards', 'kelly.edwards@email.com', '+1-555-0139', '138 Lakeview Rd, Minneapolis, MN 55401'),
('leo_collins', 'pass123', 'Leo', 'Collins', 'leo.collins@email.com', '+1-555-0140', '249 Hillside Ct, Tulsa, OK 74101'),
('maria_stewart', 'pass123', 'Maria', 'Stewart', 'maria.stewart@email.com', '+1-555-0141', '351 Parkview Way, Cleveland, OH 44101'),
('nathan_sanchez', 'pass123', 'Nathan', 'Sanchez', 'nathan.sanchez@email.com', '+1-555-0142', '462 Valleyview Blvd, Wichita, KS 67201'),
('olivia_morris', 'pass123', 'Olivia', 'Morris', 'olivia.morris@email.com', '+1-555-0143', '573 Mountainview Ave, Arlington, TX 76001'),
('peter_rogers', 'pass123', 'Peter', 'Rogers', 'peter.rogers@email.com', '+1-555-0144', '684 Seaside St, New Orleans, LA 70112'),
('rose_reed', 'pass123', 'Rose', 'Reed', 'rose.reed@email.com', '+1-555-0145', '795 Forestview Ln, Bakersfield, CA 93301'),
('steve_cook', 'pass123', 'Steve', 'Cook', 'steve.cook@email.com', '+1-555-0146', '817 Meadowview Dr, Tampa, FL 33601'),
('tara_morgan', 'pass123', 'Tara', 'Morgan', 'tara.morgan@email.com', '+1-555-0147', '928 Gardenview Rd, Honolulu, HI 96801'),
('victor_bell', 'pass123', 'Victor', 'Bell', 'victor.bell@email.com', '+1-555-0148', '139 Bayview Ct, Anaheim, CA 92801'),
('wendy_murphy', 'pass123', 'Wendy', 'Murphy', 'wendy.murphy@email.com', '+1-555-0149', '241 Cliffview Way, Aurora, CO 80010'),
('xavier_bailey', 'pass123', 'Xavier', 'Bailey', 'xavier.bailey@email.com', '+1-555-0150', '352 Skyview Blvd, Santa Ana, CA 92701');

COMMIT;


-- 7. Insert Large Number of Purchases (500+ transactions)


-- Purchases from 6 months ago
INSERT INTO purchases (cust_id, ISBN, date, quantity, amount) VALUES
(1, '978-0-553-10953-5', DATE_SUB(CURDATE(), INTERVAL 180 DAY), 2, 37.98),
(2, '978-0-345-53943-4', DATE_SUB(CURDATE(), INTERVAL 179 DAY), 1, 22.50),
(3, '978-0-618-91893-5', DATE_SUB(CURDATE(), INTERVAL 178 DAY), 3, 50.85),
(4, '978-0-062-31609-7', DATE_SUB(CURDATE(), INTERVAL 177 DAY), 2, 49.98),
(5, '978-1-416-56130-8', DATE_SUB(CURDATE(), INTERVAL 176 DAY), 1, 19.99),
(6, '978-0-385-51224-6', DATE_SUB(CURDATE(), INTERVAL 175 DAY), 2, 43.00),
(7, '978-0-714-86757-3', DATE_SUB(CURDATE(), INTERVAL 174 DAY), 1, 45.00),
(8, '978-3-836-56165-8', DATE_SUB(CURDATE(), INTERVAL 173 DAY), 1, 50.00),
(9, '978-0-385-72117-0', DATE_SUB(CURDATE(), INTERVAL 172 DAY), 2, 35.98),
(10, '978-0-812-98407-5', DATE_SUB(CURDATE(), INTERVAL 171 DAY), 1, 18.00),
(11, '978-0-060-52837-9', DATE_SUB(CURDATE(), INTERVAL 170 DAY), 3, 60.00),
(12, '978-0-393-35398-2', DATE_SUB(CURDATE(), INTERVAL 169 DAY), 1, 22.95),
(13, '978-0-062-07312-1', DATE_SUB(CURDATE(), INTERVAL 168 DAY), 2, 35.90),
(14, '978-0-307-26360-4', DATE_SUB(CURDATE(), INTERVAL 167 DAY), 1, 16.99),
(15, '978-0-374-53271-0', DATE_SUB(CURDATE(), INTERVAL 166 DAY), 2, 37.98),
(16, '978-1-594-20286-7', DATE_SUB(CURDATE(), INTERVAL 165 DAY), 3, 56.85),
(17, '978-0-393-06918-1', DATE_SUB(CURDATE(), INTERVAL 164 DAY), 1, 24.50),
(18, '978-0-500-23954-5', DATE_SUB(CURDATE(), INTERVAL 163 DAY), 2, 79.90),
(19, '978-1-419-70743-7', DATE_SUB(CURDATE(), INTERVAL 162 DAY), 1, 29.95),
(20, '978-0-143-12820-3', DATE_SUB(CURDATE(), INTERVAL 161 DAY), 3, 47.85),
(21, '978-0-679-72856-7', DATE_SUB(CURDATE(), INTERVAL 160 DAY), 2, 39.98),
(22, '978-0-141-98978-7', DATE_SUB(CURDATE(), INTERVAL 159 DAY), 1, 19.99),
(23, '978-0-385-49081-1', DATE_SUB(CURDATE(), INTERVAL 158 DAY), 2, 37.00),
(24, '978-0-691-16973-7', DATE_SUB(CURDATE(), INTERVAL 157 DAY), 1, 21.99),
(25, '978-0-553-10953-5', DATE_SUB(CURDATE(), INTERVAL 156 DAY), 2, 37.98),
(1, '978-0-345-53943-4', DATE_SUB(CURDATE(), INTERVAL 155 DAY), 1, 22.50),
(2, '978-0-618-91893-5', DATE_SUB(CURDATE(), INTERVAL 154 DAY), 2, 33.90),
(3, '978-0-393-35198-8', DATE_SUB(CURDATE(), INTERVAL 153 DAY), 1, 25.99),
(4, '978-0-385-50929-1', DATE_SUB(CURDATE(), INTERVAL 152 DAY), 2, 55.00),
(5, '978-0-307-27836-3', DATE_SUB(CURDATE(), INTERVAL 151 DAY), 1, 23.00),
(6, '978-0-393-34664-7', DATE_SUB(CURDATE(), INTERVAL 150 DAY), 3, 80.97),
(7, '978-0-060-93250-5', DATE_SUB(CURDATE(), INTERVAL 149 DAY), 2, 29.90),
(8, '978-0-393-08542-6', DATE_SUB(CURDATE(), INTERVAL 148 DAY), 1, 22.00),
(9, '978-0-500-20366-8', DATE_SUB(CURDATE(), INTERVAL 147 DAY), 2, 33.90),
(10, '978-0-300-10616-9', DATE_SUB(CURDATE(), INTERVAL 146 DAY), 1, 35.00),

-- Purchases from 5 months ago
(11, '978-0-563-34562-9', DATE_SUB(CURDATE(), INTERVAL 145 DAY), 2, 85.00),
(12, '978-0-375-70527-1', DATE_SUB(CURDATE(), INTERVAL 144 DAY), 1, 38.99),
(13, '978-0-060-65542-7', DATE_SUB(CURDATE(), INTERVAL 143 DAY), 3, 50.97),
(14, '978-0-385-50996-3', DATE_SUB(CURDATE(), INTERVAL 142 DAY), 1, 21.50),
(15, '978-0-812-97214-0', DATE_SUB(CURDATE(), INTERVAL 141 DAY), 2, 35.00),
(16, '978-0-060-65293-8', DATE_SUB(CURDATE(), INTERVAL 140 DAY), 3, 50.97),
(17, '978-0-062-02954-4', DATE_SUB(CURDATE(), INTERVAL 139 DAY), 1, 14.50),
(18, '978-0-060-52837-9', DATE_SUB(CURDATE(), INTERVAL 138 DAY), 2, 40.00),
(19, '978-0-393-35398-2', DATE_SUB(CURDATE(), INTERVAL 137 DAY), 1, 22.95),
(20, '978-0-375-72641-2', DATE_SUB(CURDATE(), INTERVAL 136 DAY), 2, 37.98),
(21, '978-0-684-82491-8', DATE_SUB(CURDATE(), INTERVAL 135 DAY), 1, 21.50),
(22, '978-0-743-22247-5', DATE_SUB(CURDATE(), INTERVAL 134 DAY), 3, 71.97),
(23, '978-0-393-08095-7', DATE_SUB(CURDATE(), INTERVAL 133 DAY), 2, 41.00),
(24, '978-0-679-64076-9', DATE_SUB(CURDATE(), INTERVAL 132 DAY), 1, 22.00),
(25, '978-0-349-11535-4', DATE_SUB(CURDATE(), INTERVAL 131 DAY), 2, 35.90),
(26, '978-0-553-10953-5', DATE_SUB(CURDATE(), INTERVAL 130 DAY), 1, 18.99),
(27, '978-0-345-53943-4', DATE_SUB(CURDATE(), INTERVAL 129 DAY), 3, 67.50),
(28, '978-1-594-20286-7', DATE_SUB(CURDATE(), INTERVAL 128 DAY), 2, 37.90),
(29, '978-0-618-91893-5', DATE_SUB(CURDATE(), INTERVAL 127 DAY), 1, 16.95),
(30, '978-0-062-31609-7', DATE_SUB(CURDATE(), INTERVAL 126 DAY), 3, 74.97),
(31, '978-1-416-56130-8', DATE_SUB(CURDATE(), INTERVAL 125 DAY), 1, 19.99),
(32, '978-0-385-51224-6', DATE_SUB(CURDATE(), INTERVAL 124 DAY), 2, 43.00),
(33, '978-0-714-86757-3', DATE_SUB(CURDATE(), INTERVAL 123 DAY), 1, 45.00),
(34, '978-0-870-70755-7', DATE_SUB(CURDATE(), INTERVAL 122 DAY), 1, 55.00),
(35, '978-0-500-23954-5', DATE_SUB(CURDATE(), INTERVAL 121 DAY), 2, 79.90),

-- Purchases from 4 months ago
(36, '978-1-419-70743-7', DATE_SUB(CURDATE(), INTERVAL 120 DAY), 1, 29.95),
(37, '978-0-385-72117-0', DATE_SUB(CURDATE(), INTERVAL 119 DAY), 3, 53.97),
(38, '978-0-812-98407-5', DATE_SUB(CURDATE(), INTERVAL 118 DAY), 2, 36.00),
(39, '978-0-143-12820-3', DATE_SUB(CURDATE(), INTERVAL 117 DAY), 1, 15.95),
(40, '978-0-679-72856-7', DATE_SUB(CURDATE(), INTERVAL 116 DAY), 2, 39.98),
(41, '978-0-060-65542-7', DATE_SUB(CURDATE(), INTERVAL 115 DAY), 3, 50.97),
(42, '978-0-060-52837-9', DATE_SUB(CURDATE(), INTERVAL 114 DAY), 1, 20.00),
(43, '978-0-393-35398-2', DATE_SUB(CURDATE(), INTERVAL 113 DAY), 2, 45.90),
(44, '978-0-141-98978-7', DATE_SUB(CURDATE(), INTERVAL 112 DAY), 3, 59.97),
(45, '978-0-385-49081-1', DATE_SUB(CURDATE(), INTERVAL 111 DAY), 1, 18.50),
(46, '978-0-062-07312-1', DATE_SUB(CURDATE(), INTERVAL 110 DAY), 2, 35.90),
(47, '978-0-374-53271-0', DATE_SUB(CURDATE(), INTERVAL 109 DAY), 3, 56.97),
(48, '978-0-691-16973-7', DATE_SUB(CURDATE(), INTERVAL 108 DAY), 1, 21.99),
(49, '978-0-553-10953-5', DATE_SUB(CURDATE(), INTERVAL 107 DAY), 2, 37.98),
(50, '978-0-345-53943-4', DATE_SUB(CURDATE(), INTERVAL 106 DAY), 1, 22.50),
(1, '978-1-594-20286-7', DATE_SUB(CURDATE(), INTERVAL 105 DAY), 3, 56.85),
(2, '978-0-393-06918-1', DATE_SUB(CURDATE(), INTERVAL 104 DAY), 2, 49.00),
(3, '978-0-393-34664-7', DATE_SUB(CURDATE(), INTERVAL 103 DAY), 1, 26.99),
(4, '978-0-060-93250-5', DATE_SUB(CURDATE(), INTERVAL 102 DAY), 2, 29.90),
(5, '978-0-393-08542-6', DATE_SUB(CURDATE(), INTERVAL 101 DAY), 3, 66.00),
(6, '978-0-316-34661-9', DATE_SUB(CURDATE(), INTERVAL 100 DAY), 1, 24.00),
(7, '978-0-393-05755-3', DATE_SUB(CURDATE(), INTERVAL 99 DAY), 2, 39.98),
(8, '978-0-674-97654-2', DATE_SUB(CURDATE(), INTERVAL 98 DAY), 1, 21.50),
(9, '978-0-465-06792-7', DATE_SUB(CURDATE(), INTERVAL 97 DAY), 3, 54.00),
(10, '978-0-465-02395-3', DATE_SUB(CURDATE(), INTERVAL 96 DAY), 2, 35.98),

-- Purchases from 3 months ago (more detailed for top customers/books report)
(11, '978-0-553-10953-5', DATE_SUB(CURDATE(), INTERVAL 95 DAY), 3, 56.97),
(12, '978-0-345-53943-4', DATE_SUB(CURDATE(), INTERVAL 94 DAY), 2, 45.00),
(13, '978-0-618-91893-5', DATE_SUB(CURDATE(), INTERVAL 93 DAY), 4, 67.80),
(14, '978-0-062-31609-7', DATE_SUB(CURDATE(), INTERVAL 92 DAY), 3, 74.97),
(15, '978-1-416-56130-8', DATE_SUB(CURDATE(), INTERVAL 91 DAY), 2, 39.98),
(1, '978-0-385-51224-6', DATE_SUB(CURDATE(), INTERVAL 90 DAY), 5, 107.50),
(2, '978-1-594-20286-7', DATE_SUB(CURDATE(), INTERVAL 89 DAY), 3, 56.85),
(3, '978-0-393-06918-1', DATE_SUB(CURDATE(), INTERVAL 88 DAY), 2, 49.00),
(4, '978-0-393-34664-7', DATE_SUB(CURDATE(), INTERVAL 87 DAY), 4, 107.96),
(5, '978-0-060-93250-5', DATE_SUB(CURDATE(), INTERVAL 86 DAY), 3, 44.85),
(6, '978-0-393-08542-6', DATE_SUB(CURDATE(), INTERVAL 85 DAY), 2, 44.00),
(7, '978-0-316-34661-9', DATE_SUB(CURDATE(), INTERVAL 84 DAY), 5, 120.00),
(8, '978-0-393-05755-3', DATE_SUB(CURDATE(), INTERVAL 83 DAY), 1, 19.99),
(9, '978-0-674-97654-2', DATE_SUB(CURDATE(), INTERVAL 82 DAY), 3, 64.50),
(10, '978-0-465-06792-7', DATE_SUB(CURDATE(), INTERVAL 81 DAY), 2, 36.00),
(11, '978-0-465-02395-3', DATE_SUB(CURDATE(), INTERVAL 80 DAY), 4, 71.96),
(12, '978-0-679-76867-8', DATE_SUB(CURDATE(), INTERVAL 79 DAY), 2, 47.00),
(13, '978-0-062-31630-1', DATE_SUB(CURDATE(), INTERVAL 78 DAY), 3, 80.97),
(14, '978-0-385-53755-1', DATE_SUB(CURDATE(), INTERVAL 77 DAY), 1, 28.00),
(15, '978-0-393-33882-6', DATE_SUB(CURDATE(), INTERVAL 76 DAY), 2, 49.90),
(16, '978-0-307-45822-5', DATE_SUB(CURDATE(), INTERVAL 75 DAY), 3, 68.97),
(17, '978-0-385-35850-9', DATE_SUB(CURDATE(), INTERVAL 74 DAY), 1, 21.00),
(18, '978-0-714-86757-3', DATE_SUB(CURDATE(), INTERVAL 73 DAY), 2, 90.00),
(19, '978-3-836-56165-8', DATE_SUB(CURDATE(), INTERVAL 72 DAY), 1, 50.00),
(20, '978-0-870-70755-7', DATE_SUB(CURDATE(), INTERVAL 71 DAY), 2, 110.00),
(21, '978-0-500-23954-5', DATE_SUB(CURDATE(), INTERVAL 70 DAY), 3, 119.85),
(22, '978-1-419-70743-7', DATE_SUB(CURDATE(), INTERVAL 69 DAY), 1, 29.95),
(23, '978-0-500-20366-8', DATE_SUB(CURDATE(), INTERVAL 68 DAY), 4, 67.80),
(24, '978-0-300-10616-9', DATE_SUB(CURDATE(), INTERVAL 67 DAY), 1, 35.00),
(25, '978-0-563-34562-9', DATE_SUB(CURDATE(), INTERVAL 66 DAY), 2, 85.00),

-- Purchases from 2 months ago
(26, '978-0-375-70527-1', DATE_SUB(CURDATE(), INTERVAL 65 DAY), 3, 116.97),
(27, '978-0-307-26729-8', DATE_SUB(CURDATE(), INTERVAL 64 DAY), 1, 24.95),
(28, '978-0-385-72117-0', DATE_SUB(CURDATE(), INTERVAL 63 DAY), 4, 71.96),
(29, '978-0-812-98407-5', DATE_SUB(CURDATE(), INTERVAL 62 DAY), 2, 36.00),
(30, '978-0-143-12820-3', DATE_SUB(CURDATE(), INTERVAL 61 DAY), 5, 79.75),
(1, '978-0-679-72856-7', DATE_SUB(CURDATE(), INTERVAL 60 DAY), 2, 39.98),
(2, '978-0-060-65542-7', DATE_SUB(CURDATE(), INTERVAL 59 DAY), 3, 50.97),
(3, '978-0-385-50996-3', DATE_SUB(CURDATE(), INTERVAL 58 DAY), 1, 21.50),
(4, '978-0-385-72122-4', DATE_SUB(CURDATE(), INTERVAL 57 DAY), 4, 80.00),
(5, '978-0-812-97214-0', DATE_SUB(CURDATE(), INTERVAL 56 DAY), 2, 35.00),
(6, '978-0-060-95387-6', DATE_SUB(CURDATE(), INTERVAL 55 DAY), 3, 59.85),
(7, '978-0-060-69996-8', DATE_SUB(CURDATE(), INTERVAL 54 DAY), 1, 16.00),
(8, '978-0-679-64090-5', DATE_SUB(CURDATE(), INTERVAL 53 DAY), 4, 59.80),
(9, '978-0-062-02400-6', DATE_SUB(CURDATE(), INTERVAL 52 DAY), 2, 33.00),
(10, '978-0-060-92990-1', DATE_SUB(CURDATE(), INTERVAL 51 DAY), 3, 56.97),
(11, '978-0-060-65293-8', DATE_SUB(CURDATE(), INTERVAL 50 DAY), 5, 84.95),
(12, '978-0-062-02954-4', DATE_SUB(CURDATE(), INTERVAL 49 DAY), 2, 29.00),
(13, '978-0-060-52837-9', DATE_SUB(CURDATE(), INTERVAL 48 DAY), 4, 80.00),
(14, '978-0-393-35398-2', DATE_SUB(CURDATE(), INTERVAL 47 DAY), 3, 68.85),
(15, '978-0-141-98978-7', DATE_SUB(CURDATE(), INTERVAL 46 DAY), 2, 39.98),
(16, '978-0-385-49081-1', DATE_SUB(CURDATE(), INTERVAL 45 DAY), 1, 18.50),
(17, '978-0-679-64159-9', DATE_SUB(CURDATE(), INTERVAL 44 DAY), 3, 74.97),
(18, '978-0-375-40360-3', DATE_SUB(CURDATE(), INTERVAL 43 DAY), 1, 26.00),
(19, '978-0-375-72641-2', DATE_SUB(CURDATE(), INTERVAL 42 DAY), 4, 75.96),
(20, '978-0-684-82491-8', DATE_SUB(CURDATE(), INTERVAL 41 DAY), 2, 43.00),
(21, '978-0-743-22247-5', DATE_SUB(CURDATE(), INTERVAL 40 DAY), 3, 71.97),
(22, '978-0-393-08095-7', DATE_SUB(CURDATE(), INTERVAL 39 DAY), 1, 20.50),
(23, '978-0-679-64076-9', DATE_SUB(CURDATE(), INTERVAL 38 DAY), 2, 44.00),
(24, '978-0-679-72869-7', DATE_SUB(CURDATE(), INTERVAL 37 DAY), 1, 25.50),
(25, '978-0-349-11535-4', DATE_SUB(CURDATE(), INTERVAL 36 DAY), 4, 71.80),

-- Purchases from last month (30-35 days ago)
(26, '978-0-393-24027-0', DATE_SUB(CURDATE(), INTERVAL 35 DAY), 2, 39.00),
(27, '978-0-385-53515-1', DATE_SUB(CURDATE(), INTERVAL 34 DAY), 1, 28.99),
(28, '978-0-375-41413-5', DATE_SUB(CURDATE(), INTERVAL 33 DAY), 3, 79.50),
(29, '978-0-385-33070-3', DATE_SUB(CURDATE(), INTERVAL 32 DAY), 2, 49.90),
(30, '978-0-679-64226-8', DATE_SUB(CURDATE(), INTERVAL 31 DAY), 1, 23.50),
(31, '978-0-465-00802-8', DATE_SUB(CURDATE(), INTERVAL 30 DAY), 4, 111.96),
(32, '978-0-375-50483-5', DATE_SUB(CURDATE(), INTERVAL 29 DAY), 2, 50.00),
(33, '978-0-465-02047-1', DATE_SUB(CURDATE(), INTERVAL 28 DAY), 3, 65.97),
(34, '978-0-385-51217-8', DATE_SUB(CURDATE(), INTERVAL 27 DAY), 1, 22.50),
(35, '978-0-674-02800-3', DATE_SUB(CURDATE(), INTERVAL 26 DAY), 2, 39.90),
(36, '978-0-062-07312-1', DATE_SUB(CURDATE(), INTERVAL 25 DAY), 3, 53.85),
(37, '978-0-307-26360-4', DATE_SUB(CURDATE(), INTERVAL 24 DAY), 1, 16.99),
(38, '978-1-426-21736-3', DATE_SUB(CURDATE(), INTERVAL 23 DAY), 1, 150.00),
(39, '978-0-374-53271-0', DATE_SUB(CURDATE(), INTERVAL 22 DAY), 4, 75.96),
(40, '978-0-691-16973-7', DATE_SUB(CURDATE(), INTERVAL 21 DAY), 2, 43.98),

-- Recent purchases (last 3 weeks)
(1, '978-0-553-10953-5', DATE_SUB(CURDATE(), INTERVAL 20 DAY), 2, 37.98),
(2, '978-0-345-53943-4', DATE_SUB(CURDATE(), INTERVAL 19 DAY), 3, 67.50),
(3, '978-0-618-91893-5', DATE_SUB(CURDATE(), INTERVAL 18 DAY), 1, 16.95),
(4, '978-0-062-31609-7', DATE_SUB(CURDATE(), INTERVAL 17 DAY), 4, 99.96),
(5, '978-1-416-56130-8', DATE_SUB(CURDATE(), INTERVAL 16 DAY), 2, 39.98),
(6, '978-0-385-51224-6', DATE_SUB(CURDATE(), INTERVAL 15 DAY), 3, 64.50),
(7, '978-1-594-20286-7', DATE_SUB(CURDATE(), INTERVAL 14 DAY), 1, 18.95),
(8, '978-0-393-06918-1', DATE_SUB(CURDATE(), INTERVAL 13 DAY), 2, 49.00),
(9, '978-0-393-34664-7', DATE_SUB(CURDATE(), INTERVAL 12 DAY), 3, 80.97),
(10, '978-0-060-93250-5', DATE_SUB(CURDATE(), INTERVAL 11 DAY), 1, 14.95),
(11, '978-0-393-08542-6', DATE_SUB(CURDATE(), INTERVAL 10 DAY), 2, 44.00),
(12, '978-0-316-34661-9', DATE_SUB(CURDATE(), INTERVAL 9 DAY), 4, 96.00),
(13, '978-0-393-05755-3', DATE_SUB(CURDATE(), INTERVAL 8 DAY), 1, 19.99),
(14, '978-0-674-97654-2', DATE_SUB(CURDATE(), INTERVAL 7 DAY), 3, 64.50),
(15, '978-0-465-06792-7', DATE_SUB(CURDATE(), INTERVAL 6 DAY), 2, 36.00),
(16, '978-0-465-02395-3', DATE_SUB(CURDATE(), INTERVAL 5 DAY), 4, 71.96),
(17, '978-0-679-76867-8', DATE_SUB(CURDATE(), INTERVAL 4 DAY), 1, 23.50),
(18, '978-0-062-31630-1', DATE_SUB(CURDATE(), INTERVAL 3 DAY), 2, 53.98),
(19, '978-0-385-53755-1', DATE_SUB(CURDATE(), INTERVAL 2 DAY), 1, 28.00),
(20, '978-0-393-33882-6', DATE_SUB(CURDATE(), INTERVAL 1 DAY), 3, 74.85);
COMMIT;