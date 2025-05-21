/* create "Customer" table, this table is meant to identify a buyer in the e-commerce
website, holds all information related to the actions of the buyer that will be needed 
as they naviagte the application
*/
CREATE TABLE Customer
(
	customer_id INT AUTO_INCREMENT,
    PRIMARY KEY(customer_id),
    fname VARCHAR(250),
    lname VARCHAR(250),
    email VARCHAR(250) UNIQUE,
    username VARCHAR(250) UNIQUE NOT NULL,
    phone_num INT,
    user_password VARCHAR(250) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
    
);

/* Addresses of buyers, soecies addresses where services must be rendered or where purchases should be shipped off to*/
CREATE TABLE Shipping_Address
(
	address_id INT AUTO_INCREMENT,
    PRIMARY KEY(address_id),
    address VARCHAR(250),
    IsDefault BOOL,
    customer_id INT,
    FOREIGN KEY(customer_id) REFERENCES Customer(customer_id) ON DELETE CASCADE
    
);

/*invoice of items ordered by buyer or apponitments set and how much they would cost the buyer*/

CREATE TABLE Customer_Order
(
	order_id INT AUTO_INCREMENT,
    PRIMARY KEY(order_id),
	total FLOAT, /*total buyer is being charged*/
    customer_id INT,
    FOREIGN KEY(customer_id) REFERENCES Customer(customer_id) ON DELETE CASCADE,
    order_status VARCHAR(100) /* 'PENDING'; 'SHIPPED'; 'DELIVERED', 'DISPUTE' ETC */
    
);

/* Table to track appountennts made by buyer to render a service from the seller */
CREATE TABLE Appointment
(
	Appointment_id INT AUTO_INCREMENT,
    PRIMARY KEY(Appointment_id),
    customer_id INT,
    FOREIGN KEY(customer_id) REFERENCES Customer(customer_id) ON DELETE CASCADE,
    Date DATE,
    item_id INT,
    FOREIGN KEY(item_id) REFERENCES Items(item_id) ON DELETE CASCADE,
    Appointemnet_Status VARCHAR(100),
    Seller_id INT,
    FOREIGN KEY(seller_id) REFERENCES Seller(seller_id) ON DELETE CASCADE
    
);

/* Manages payments done on application*/
CREATE TABLE Escrow_Payment
(
	EscrowPayment_id INT AUTO_INCREMENT,
    PRIMARY KEY(EscrowPayment_id),
    escrow_agent VARCHAR(250) NOT NULL,
    amount FLOAT NOT NULL,
    Payment_Due DATE NOT NULL,
    customer_id INT,
    FOREIGN KEY(customer_id) REFERENCES Customer(customer_id) ON DELETE CASCADE,
    Release_Date DATE,
    seller_id INT,
    FOREIGN KEY(Seller_id) REFERENCES Seller(seller_id) ON DELETE CASCADE,
    EP_Status VARCHAR(100)
    
);

CREATE TABLE Review
(
	Review_ID INT AUTO_INCREMENT,
    PRIMARY KEY(Review_ID ),
    customer_id INT,
    Item_id INT,
    Description TEXT,
    Create_Date DATE,
    Rating INT CHECK(RATING BETWEEN 1 AND 5),
    seller_id INT,
    
    FOREIGN KEY(customer_id) REFERENCES Customer(customer_id) ON DELETE CASCADE,
    FOREIGN KEY(item_id) REFERENCES Items(item_id) ON DELETE CASCADE,
    FOREIGN  KEY(seller_id) REFERENCES Seller(seller_id) ON DELETE CASCADE
    
);

CREATE TABLE Cart
(
	Cart_id INT AUTO_INCREMENT,
    PRIMARY KEY(Cart_id),
    Customer_id INT,
    Item_id INT,
    Quantity INT,
    Net_Total FLOAT,
    Price_at_time FLOAT,
    
    FOREIGN KEY(customer_id) REFERENCES Customer(customer_id)ON DELETE CASCADE,
    FOREIGN KEY(item_id) REFERENCES Items(item_id) ON DELETE CASCADE
    
);

CREATE TABLE Dispute
(
	Dispute_id INT AUTO_INCREMENT,
    PRIMARY KEY(Dispute_id),
    customer_id INT,
    Order_id INT,
    Dispute_Date DATE,
    Description TEXT,
    Dispute_Status TEXT DEFAULT "Pending",
    
    FOREIGN KEY(customer_id) REFERENCES Customer(customer_id) ON DELETE CASCADE,
    FOREIGN KEY(Order_id) REFERENCES Orders(Order_id) ON DELETE CASCADE
    
    
);

CREATE TABLE Order_Items
(
	Order_Items_id INT AUTO_INCREMENT,
    PRIMARY KEY(Order_Items_id),
    Order_id INT,
    Item_id INT,
    QuantitY INT NOT NULL,
    
    FOREIGN KEY(Order_id) REFERENCES Orders(Order_id) ON DELETE CASCADE,
    FOREIGN KEY(Item_id) REFERENCES Items(item_id) ON DELETE CASCADE
    
);

CREATE TABLE WISHLIST
(
	Wishlist_id INT AUTO_INCREMENT,
    PRIMARY KEY(Wishlist_id),
    Customer_id INT,
    Item_id INT,
    Date_added DATE,
    
    FOREIGN KEY(Customer_id) REFERENCES Customer(Customer_id),
    FOREIGN KEY(Item_id) REFERENCES Item(Item_id)
    
);


CREATE TABLE LOGIN
(
	Login_id INT AUTO_INCREMENT,
    PRIMARY KEY(Login_id),
    /* EITHER CUSTOMER, SELLER OR ADMIN */
    customer_id INT,
    seller_id INT,
    Admin_id INT,
    Login_Time TIMESTAMP,
    IP_Address INT,
    Device_info TEXT,
    Login_Status VARCHAR(30) DEFAULT "offline",
    
    FOREIGN KEY(customer_id) REFERENCES Customer(customer_id) ON DELETE CASCADE,
    FOREIGN KEY(seller_id) REFERENCES Seller(seller_id) ON DELETE CASCADE,
    FOREIGN KEY(Admin_id) REFERENCES Admin(Admin_id) ON DELETE CASCADE
    
);

CREATE TABLE Seller
(
	seller_id INT AUTO_INCREMENT,
    PRIMARY KEY (Seller_id),
    fname VARCHAR(250),
    lname VARCHAR(250),
    Email VARCHAR(250),
    username VARCHAR(250) UNIQUE,
    seller_Password VARCHAR(250),
    address_id INT,
    phone_Num INT CHECK IF LENGTH IS 10,
    skills_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    FOREIGN KEY(address_id) REFERENCES Shipping_Address(address_id) ON DELETE CASCADE,
    FOREIGN KEY(skills_id) REFERENCES Skills(skills_id) ON DELETE CASCADE
    
);

CREATE TABLE Items
(
	item_id INT AUTO_INCREMENT,
    PRIMARY KEY(item_id),
    price FLOAT,
    Description TEXT,
    Category /* either goods or services*/ TEXT
    
);

CREATE TABLE Skills
(
	skills_id INT AUTO_INCREMENT,
    PRIMARY KEY(skills_id),
    Title TEXT,
    Description TEXT,
    Proficiency INT CHECK(Proficiency BETWEEN 1 AND 5)
    
);

CREATE TABLE Seller_Skills /* Table to resovle the amny relationship between seller and skills*/
(
	Seller_Skills_id INT AUTO_INCREMENT,
    PRIMARY KEY(Seller_Skills_id),
    seller_id INT,
    skills_id INT,
    
    FOREIGN KEY(seller_id) REFERENCES Seller(seller_id) ON DELETE CASCADE,
    FOREIGN KEY(skills_id) REFERENCES Skills(skills_id) ON DELETE CASCADE
    
);

/* TO VERIFY SELLER*/
CREATE TABLE Verification
(
	Verification_id INT AUTO_INCREMENT,
    PRIMARY KEY(Verification_id),
    seller_id INT,
    verification_Status TEXT,
    Submit_Date TIMESTAMP,
    Reviewed_Date TIMESTAMP,
    Supporting_Docs BLOB,
    
    FOREIGN KEY(seller_id) REFERENCES Seller(seller_id)
    
);

CREATE TABLE Seller_ANALYTICS
(
	analysis_id INT AUTO_INCREMENT,
    PRIMARY KEY(analysis_id),
    total_sales INT DEFAULT 0,
    total_earnings INT DEFAULT 0
);
    
    

CREATE TABLE Admin
(
	Admin VARCHAR(250),
    PRIMARY KEY(Admin),
    fname VARCHAR(250),
    lname VARCHAR(250),
    role_id VARCHAR(250),
    phone_num INT CHECK IF LENGTH IS 10,
    username VARCHAR(250) UNIQUE NOT NULL,
    Admin_password VARCHAR(250),
    Last_Login TIMESTAMP,
    Admin_Status VARCHAR(250),
    
    FOREIGN KEY(role_id) REFERENCES Role(role_id)
    
);


CREATE TABLE Role
(
	role_id INT AUTO_INCREMENT,
    PRIMARY KEY(role_id),
    fname VARCHAR(250),
    Description TEXT,
    Department_id INT,
    Permissions TEXT,
    
    FOREIGN KEY(Department_id) REFERENCES Department(Department_id) ON DELETE CASCADE
    
);

CREATE TABLE Admin_Audit_Log
(
	Log_id INT AUTO_INCREMENT,
    PRIMARY KEY(Log_id),
    admin_id INT,
    Admin_Action BOOLEAN, /* What did they do */
    ip_address INT,
    Log_Date TIMESTAMP,
    Details TEXT,
    
    
    FOREIGN KEY(admin_id) REFERENCES Admin(admin_id)
    
);

CREATE TABLE Report
(
	report_id INT AUTO_INCREMENT,
    PRIMARY KEY(report_id),
	repert_file BLOB,
	admin_id INT,
    report_date date
    
);

   
    
    
	

    
    
    
    
    
    
    
    
    
    
    
	
    

    
