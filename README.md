# SmartTax -A Self-Assesment Tool for Uk Freelancers

**Author:** Tunde Debreczeni
**Course** Bcs (Hons) Applied Computing, Univresity of Wales Trinity Saint David

## System Architecture

The SmartTax system runs as a **multi container Docker Applicattion ** with three core services:

1. **Frontend** - React & Tailwind CSS
   -Provides a progressive and user -friendly dashboard interface.
2. **Backend API** - Node. Js & Express
   -Handels business logic , data validation , and tax calculations.
3.**Database** - PostgreSQL
   - Stores users data , income, expenses, and tax records.
Each service runs in  its own container , alowing isolation and easy scaling.
Communication betwen containers is handeled internally trough Docker's network.


## Features
-Usre -friendly **React interface for freelancers to mannage income and expenses.
-Automatic **tax and National Insurante estimations** based on UK trasholds.
-Integration-ready for **HMRC's Making Tax Digital** API. 
-Secure **PostgreSQL** data storage. 
-Live **hot-reload developement enviroment** with Docker bind mounts.
-Full **portability** - run the entire stack with one commnd


## Teck Stack 

| Component | Technology |
|Frontende| React 18, Tailwind CSS, Vite |
|Beckend| Node.Js 20, Express, JWT, Bcrypt|
|Database| PostgreSQL 16 |
|Enviroment| Docker , Docker Compose |
|Language | Javascript  (ES Modules) |


## Project Structure


