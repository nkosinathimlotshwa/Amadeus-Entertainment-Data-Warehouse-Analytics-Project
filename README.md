# Amadeus Entertainment Data Warehouse

## Project Overview

Amadeus Entertainment is a global entertainment retailer specialising in music,
films, and audio books. The company operates eight online stores across the
United States, Germany, France, the United Kingdom, Spain, Australia, Japan,
and India, supported by 96 offline retail locations across those same markets.

This project is a full end-to-end Data Warehouse implementation built as a
learning exercise based on the Apress textbook **"Building a Data Warehouse
with Examples in SQL Server"** by Vincent Rainardi (2007), upgraded and
modernised for **Microsoft SQL Server 2022**.

---

## Business Context

Customers of Amadeus Entertainment can:
- Purchase individual products such as songs, audio books, and films
- Subscribe to packages that allow a set number of downloads per month
- Stream content once at a fraction of the purchase price via online streaming

The company operates across four delivery channels:

| Channel | Description |
|---|---|
| **Internet** | Online store and streaming platform |
| **Mobile** | Mobile phone downloads and streaming |
| **Cable TV** | Television broadcast delivery |
| **Post** | Physical media delivery |

---

## Source Systems

The business runs on three core operational systems that feed the data warehouse:

| System | Type | Platform | Manages |
|---|---|---|---|
| **WebTower9** | Custom .NET | Oracle | Online sales, streaming, subscriptions |
| **Jupiter** | ERP (AS/400) | DB2 | Inventory, products, finances |
| **Jade** | Custom Java | Informix | Offline store sales, customer service |

---

## Data Warehouse Architecture

This project implements a **hybrid NDS + DDS architecture** combining the best
of both the Inmon and Kimball methodologies:
