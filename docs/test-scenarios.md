# SQL Validation Test Scenarios

## Overview

This document describes the validation scenarios used to verify data quality, referential integrity, and business rules within the Licensing Management System database.

---

## Validation Summary

| Test Case | Validation                                        | Expected Result                |
| --------- | ------------------------------------------------- | ------------------------------ |
| CT-01     | Expired licenses                                  | Return expired licenses        |
| CT-02     | Active licenses with expired validity date        | No records returned            |
| CT-03     | Revoked licenses                                  | Return revoked licenses        |
| CT-04     | Licenses without associated person                | No records returned            |
| CT-05     | Licenses without associated city                  | No records returned            |
| CT-06     | Duplicate CPF values                              | No records returned            |
| CT-07     | People without city of residence                  | No records returned            |
| CT-08     | Invalid license status                            | No records returned            |
| CT-09     | License issue date greater than expiration date   | No records returned            |
| CT-10     | Cities without registered residents               | Return records for analysis    |
| CT-11     | People without licenses                           | Return records for analysis    |
| CT-12     | Licenses expiring within 90 days                  | Return licenses for monitoring |
| CT-13     | Future birth dates                                | No records returned            |
| CT-14     | Licenses associated with inactive business status | Return records for analysis    |
| CT-15     | People holding multiple licenses                  | Return records for analysis    |