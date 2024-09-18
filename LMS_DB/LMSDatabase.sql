use LMSDB;
select database();

CREATE TABLE User_Details(
Id INT unsigned Primary Key auto_increment, 
email VARCHAR(50) NOT NULL UNIQUE, 
first_name VARCHAR(50) NOT NULL , 
last_name  VARCHAR(50) NOT NULL,
Password VARCHAR(100) NOT NULL, 
contact_number VARCHAR(15) NOT NULL, 
verified BOOLEAN DEFAULT FALSE, 
creator_stamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
creator_user VARCHAR(100)
);

Create Table HiredCandidate(
Id INT PRIMARY KEY auto_increment,
first_name VARCHAR(100) NOT NULL, 
middle_name VARCHAR(100),
last_name VARCHAR(100) NOT NULL , 
email_id VARCHAR(255) NOT NULL UNIQUE, 
hired_city VARCHAR(100),
degree VARCHAR(100), 
hired Date, 
mobile_number VARCHAR(15) NOT NULL,
permanent_pincode VARCHAR(10), 
hired_lab VARCHAR(100) , 
attitude TEXT, 
communication_remark TEXT, 
knowledge_remark TEXT, 
aggregate_remark TEXT, 
status ENUM("Pending","Accepted","Rejected") DEFAULT "Pending", 
creator_stamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
creator_user INT UNSIGNED,
FOREIGN KEY(creator_user) REFERENCES User_Details(Id)
);

Create Table Fellowship_Candidate (
Id Int primary key auto_increment,
CIC_ID VARCHAR(20) UNIQUE NOT NULL, -- Example: CIC032022-11333
first_name VARCHAR(100) NOT NULL,
middle_name VARCHAR(100) ,
last_name VARCHAR(100) NOT NULL,
email_id VARCHAR(100) NOT NULL UNIQUE,
hired_city VARCHAR(100),
degree VARCHAR(50),
hired_date DATE,
mobile_number VARCHAR(15) NOT NULL,
permanent_pincode VARCHAR(10) ,
hired_lab VARCHAR(100),
attitude TEXT, 
communication_remark TEXT, 
knowledge_remark TEXT, 
aggregate_remark TEXT, 
creator_stamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
creator_user INT UNSIGNED,
birth_date DATE,
is_birth_verified BOOLEAN DEFAULT FALSE,
parent_name VARCHAR(100),
parent_occupation VARCHAR(100),
parent_mobile_number VARCHAR(15),
parents_annual_salary DECIMAL(10,2),
local_address VARCHAR(200),
permanent_address VARCHAR(200),
photo_path VARCHAR(200),
joining_date DATE,
candidate_status ENUM('Pending','Accepted','Rejected') DEFAULT 'Pending',
personal_information TEXT,
bank_information TEXT,
educational_information TEXT,
document_status TEXT,
remark TEXT,
FOREIGN KEY (creator_user) REFERENCES User_Details(Id)
);

Create Table Candidate_Bank_Details(
Id INT primary key auto_increment,
candidate_id INT NOT NULL,
name VARCHAR(100) NOT NULL,
account_number VARCHAR(20) NOT NULL,
is_account_number_verified BOOLEAN DEFAULT FALSE,
ifsc_code VARCHAR(11) NOT NULL,
is_ifsc_code_verified BOOLEAN DEFAULT FALSE,
pan_number VARCHAR(10) UNIQUE,
is_pan_number_verified BOOLEAN DEFAULT FALSE,
adhar_number VARCHAR(12) UNIQUE,
is_adhar_number_verified BOOLEAN DEFAULT FALSE,
creator_stamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
creator_user INT UNSIGNED,
FOREIGN KEY (candidate_id) REFERENCES Fellowship_Candidate(Id),
Foreign Key (creator_user) REFERENCES User_details(Id)
); 

Create Table Candidate_Qualification (
Id INT primary key auto_increment,
candidate_id INT NOT NULL,
diploma VARCHAR(50),
degree_name Varchar(150),
is_degree_name_verified BOOLEAN DEFAULT FALSE,
employee_desciplice VARCHAR(100),
employee_descipline_verified BOOLEAN default FALSE,
passing_year YEAR,
is_passing_year_verified Boolean DEFAULT FALSE,
aggr_per DECIMAL(5,2),
is_aggr_per Boolean default false,
final_year_per  DECIMAL(5,2),
is_final_per_verified Boolean default false,
training_institute VARCHAR(100),
is_training_institute_verified boolean default false,
training_duration_month INT,
is_training_duration_month_verified Boolean default false,
other_training TEXT,
is_other_training_verified BOOLEAN DEFAULT FALSE,
creator_stamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
creator_user INT UNSIGNED,
FOREIGN KEY (candidate_id) REFERENCES Fellowship_Candidate(Id),
Foreign Key (creator_user) REFERENCES User_Details(Id)
);

Create Table Candidate_Documents (
Id INT primary key auto_increment,
candidate_id INT NOT NULL,
doc_type ENUM('PAN Card','Adhar Card','Certificate') NOT NULL,
doc_path VARCHAR(200),
status ENUM('Pending','Recieved') DEFAULT 'Pending',
creator_stamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
creator_user INT UNSIGNED,
foreign key (candidate_id) REFERENCES Fellowship_Candidate(Id),
foreign key (creator_user) REFERENCES User_Details(Id)
);

Create Table Company (
Id INT PRIMARY KEY auto_increment,
name VARCHAR(100) NOT NULL,
address VARCHAR(200),
location VARCHAR(100),
status ENUM('Active','Inactive') DEFAULT 'Active',
creator_stamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
creator_user INT UNSIGNED,
FOREIGN KEY (creator_user) REFERENCES User_Details(Id)
);
 
Create Table Maker_Program (
Id INT PRIMARY KEY auto_increment, 
program_name VARCHAR(100),
program_type ENUM('Java_Full_Stack+SpringBoot+Angular','Full Stack','SDET') NOT NULL,
program_link VARCHAR(100), 
tech_stack_id INT, 
tech_type_id INT, 
is_program_approved BOOLEAN DEFAULT FALSE,
description TEXT, 
 status ENUM('Active','Inactive') DEFAULT 'Active',
 creator_stamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
 creator_user INT UNSIGNED,
 FOREIGN KEY (creator_user) REFERENCES User_Details(Id)
 );
 
 Create Table App_Parameters(
 Id INT PRIMARY KEY auto_increment,
 key_type VARCHAR(200) NOT NULL,
 key_value VARCHAR(200) NOT NULL,
 key_text VARCHAR(200), 
cur_status ENUM('ACTV','IACTV') DEFAULT 'ACTV',
lastupd_user INT unsigned, 
lastupd_stamp timestamp default current_timestamp ON update current_timestamp, 
creator_stamp timestamp default current_timestamp,
creator_user INT unsigned, 
seq_num INT NOT NULL,
FOREIGN KEY (lastupd_user) REFERENCES User_Details(Id),
FOREIGN KEY (creator_user) REFERENCES User_Details(Id)
);

show tables;

Create Table Mentor(
Id INT PRIMARY KEY auto_increment,
name VARCHAR(100) NOT NULL,
mentor_type ENUM('Main / Lead Mentor', 'Practice Head', 'Support Mentor', 'Buddy Mentor') NOT NULL,
lab_id INT NOT NULL,
status ENUM('ACTV','IACTV') DEFAULT 'ACTV',
creator_stamp timestamp default current_timestamp,
creator_user INT unsigned, 
FOREIGN KEY (creator_user) REFERENCES User_Details(Id)
);

Create Table Mentor_Ideation_Map (
Id INT PRIMARY KEY AUTO_INCREMENT,
parent_mentor_id INT NOT NULL,
mentor_id INT NOT NULL,
status ENUM('ACTV','IACTV') DEFAULT 'ACTV',
creator_stamp timestamp default current_timestamp,
creator_user INT unsigned, 
Foreign Key (parent_mentor_id) REFERENCES Mentor(Id),
Foreign Key (mentor_id) REFERENCES Mentor(Id),
Foreign Key (creator_user) REFERENCES User_Details(Id)
);

Create Table Tech_Stack (
Id INT PRIMARY KEY auto_increment,
tech_name VARCHAR(200),
image_path VARCHAR(100),
framework VARCHAR(100),
cur_status TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
creator_stamp timestamp default current_timestamp,
creator_user INT unsigned, 
Foreign Key (creator_user) REFERENCES User_Details(Id)
);

Create Table Mentor_Tech_Stack (
Id INT PRIMARY KEY auto_increment,
mentor_id INT NOT NULL,
tech_stack_id INT NOT NULL,
status ENUM('ACTV','IACTV') DEFAULT 'ACTV',
creator_stamp timestamp default current_timestamp,
creator_user INT unsigned, 
FOREIGN KEY (mentor_id) REFERENCES Mentor(Id),
foreign key (tech_stack_id) references Tech_Stack(Id),
foreign key (creator_user) references User_Details(Id)
);

Create Table Tech_Type (
Id INT PRIMARY KEY AUTO_INCREMENT,
type_name VARCHAR(100), -- Full Stack, Backend, Frontend
cur_status TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
creator_stamp timestamp default current_timestamp,
creator_user INT unsigned, 
Foreign Key (creator_user) REFERENCES User_Details(Id)
);

Create Table Lab (
Id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(200),
location VARCHAR(100), -- Mumbai, Pune, Bengalore
address VARCHAR(100),
status ENUM('ACTV','IACTV') DEFAULT 'ACTV',
creator_stamp timestamp default current_timestamp,
creator_user INT unsigned, 
Foreign Key (creator_user) REFERENCES User_Details(Id)
);


Create Table Lab_Threshold (
 Id INT PRIMARY KEY auto_increment, 
 lab_id INT NOT NULL,
 lab_capacity INT NOT NULL,
 lead_threshold INT NOT NULL ,
 ideation_engg_threshold INT NOT NULL, 
 buddy_engg_threshold INT NOT NULL,
status ENUM('ACTV','IACTV') DEFAULT 'ACTV',
creator_stamp timestamp default current_timestamp,
creator_user INT unsigned ,
foreign key (lab_id) REFERENCES Lab(Id),
foreign key (creator_user) references User_Details(Id)
);

Create Table Company_Requirement (
Id INT PRIMARY KEY auto_increment ,
company_id INT NOT NULL,
requested_month VARCHAR(7) NOT NULL, -- MM/YYYY FORMAT
city VARCHAR(100) NOT NULL,
is_doc_verification BOOLEAN default false,
requirement_doc_path VARCHAR(200),
no_off_engg INT NOT NULL,
tech_stack_id INT NOT NULL,
tech_type_id INT NOT NULL,
maker_program_id INT NOT NULL,
lead_id INT NOT NULL ,
ideation_engg_id INT NOT NULL,
buddy_engg_id INT NOT NULL,
special_remark TEXT,
status ENUM('ACTV','IACTV') DEFAULT 'ACTV',
creator_stamp timestamp default current_timestamp,
creator_user INT unsigned ,
foreign key (company_id) references Company(Id),
foreign key (tech_stack_id) references Tech_Stack(Id),
foreign key (tech_type_id) references Tech_Type(Id),
foreign key (maker_program_id) references Maker_Program(Id),
foreign key (lead_id) references Mentor(Id),
foreign key (ideation_engg_id) references Mentor(Id),
foreign key (buddy_engg_id) references Mentor(Id),
foreign key (creator_user) references User_Details(Id)
);

Create Table  Candidate_Stack_Assignment (
Id INT PRIMARY KEY auto_increment,
requirement_id INT NOT NULL,
candidate_id INT NOT NULL,
assign_date DATE NOT NULL,
complete_date DATE NOT NULL,
status ENUM('ACTV','IACTV') DEFAULT 'ACTV',
creator_stamp timestamp default current_timestamp,
creator_user INT unsigned ,
foreign key (candidate_id) references Fellowship_Candidate(Id),
foreign key (requirement_id) references Company_Requirement(Id),
foreign key (creator_user) references User_Details(Id)
);
show tables;






 









 




