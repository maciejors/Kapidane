# write a script to scrape the  compressed data from the website in csv format compressed in gz folder using api
import requests
import gzip
import csv
import os


def download_file(url, output_file):
    # Send a GET request to the API endpoint
    response = requests.get(url)

    # Check if the request was successful (status code 200)
    if response.status_code == 200:
        # Save the response content to a file
        with open(f'{output_file}.gz', 'wb') as file:
            file.write(response.content)
        with gzip.open(f'{output_file}.gz', 'rb') as file:
            # Read the CSV data
            csv_data = file.read().decode('utf-8')
        with open(output_file, 'w', newline='') as file:
            writer = csv.writer(file)
            # Split the CSV data by lines and iterate over them
            for line in csv_data.splitlines():
                # Split each line by commas and write it to the CSV file
                writer.writerow(line.split(','))
        os.remove(f'{output_file}.gz')
        print(f"File '{output_file}' downloaded and saved successfully.")
    else:
        print(
            f"Failed to download the file. Status code: {response.status_code}")


def download_country_data():
    # World Bank API URL for WDI metadata
    url = "https://api.worldbank.org/v2/sources/2/country/all/metadata?format=json&per_page=10000"

    # Send GET request to the API
    response = requests.get(url)

    # Check if the request was successful
    if response.status_code == 200:
        # Extract the JSON data from the response
        data = response.json()["source"][0]["concept"][0]["variable"]

        # Extract the necessary information from the JSON data
        headers = ["Country Code", "Country Name",
                   "Income Group", "Region", "Country Long Name"]
        rows = []
        for country in data:
            region = ""
            income_group = ""
            country_code = ""
            country_name = ""
            country_long_name = ""
            for item in country["metatype"]:
                if item["id"] == "Region":
                    region = item["value"]
                elif item["id"] == "IncomeGroup":
                    income_group = item["value"]
                elif item["id"] == "2-alphacode":
                    country_code = item["value"]
                elif item["id"] == "ShortName":
                    country_name = item["value"]
                elif item["id"] == "LongName":
                    country_long_name = item["value"]

            rows.append([country_code, country_name,
                        income_group, region, country_long_name])

        # Write the extracted data to a CSV file
        with open("raw_data\\countries.csv", "w", newline="",  encoding="utf-8") as csvfile:
            writer = csv.writer(csvfile)
            writer.writerow(headers)
            writer.writerows(rows)

        print("Metadata downloaded and saved as 'countries.csv'.")
    else:
        print("Failed to retrieve metadata. Please check your request.")


if __name__ == "__main__":
    data_dict = {"raw_data\\trips.csv": "https://ec.europa.eu/eurostat/api/dissemination/sdmx/2.1/data/TOUR_DEM_TTW/?format=SDMX-CSV&compressed=true",
                 "raw_data\\expenditures.csv": "https://ec.europa.eu/eurostat/api/dissemination/sdmx/2.1/data/TOUR_DEM_EXTOTW/?format=SDMX-CSV&compressed=true",
                 "raw_data\\nights.csv": "https://ec.europa.eu/eurostat/api/dissemination/sdmx/2.1/data/TOUR_DEM_TNW/?format=SDMX-CSV&compressed=true", }

    for key, value in data_dict.items():
        download_file(value, key)

    download_country_data()
