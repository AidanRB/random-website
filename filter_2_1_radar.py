#!/usr/bin/env python3

import requests
import json
from multiprocessing import Pool, Manager


url = "https://api.cloudflare.com/client/v4/accounts/df91b60d266eef17b744e15350b6ee23/intel/domain"

headers = {
    "Content-Type": "application/json",
    "Authorization": "Bearer tBPSpc7228pl4Gmq4fOtHeQlKPSTROP1DSEh1pEU",
}

domains = open("radar-200.csv", "r").read().split("\n")


def check_domain(domain):
    response = requests.request("GET", url, params={"domain": domain}, headers=headers)

    response_data = json.loads(response.text)["result"]
    print(response.text)

    if "content_categories" in response_data:
        return [{response_data["domain"]: response_data["content_categories"]}]
    else:
        return [{response_data["domain"]: []}]


def run_check_domain(domain, domains_data):
    try:
        result = check_domain(domain)
        domains_data.append(result)
        print(result[0])
    except Exception as e:
        print(f"Error occurred for domain: {domain}")
        print(f"Error message: {str(e)}")


if __name__ == "__main__":
    manager = Manager()
    domains_data = manager.list()

    pool = Pool(processes=10)
    pool.starmap(run_check_domain, [(domain, domains_data) for domain in domains])
    pool.close()
    pool.join()

    domains_data = list(domains_data)
