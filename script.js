let timeoutId;

// get sites from sites.txt
async function get_sites() {
    try {
        const response = await fetch('sites.txt')
        const data = await response.text()
        const sitesArray = data.split('\n')
        return sitesArray
    } catch (error) {
        console.error('Error: ', error)
        return []; // Return an empty array or handle the error accordingly
    }
}

// pick a random site from sites
function get_random_site(sites) {
    return sites[Math.floor(Math.random() * sites.length)];
}

function stop_navigation() {
    // stop timer
    clearTimeout(timeoutId);

    // reset css classes and button text
    document.getElementById("button_text").innerHTML = "surf's up!";
    document.getElementById("button").classList.remove("stop");
    document.getElementById("loader").classList.remove("loading");

    // remove event listeners
    document.getElementById("button").removeEventListener("mouseout", stop_navigation);
}

function navigate_to_site(site) {
    // navigate to site in new tab
    window.open("https://" + site, "_blank")
    stop_navigation();
}

function initiate_navigation(sites) {
    // stop any previous navigation
    stop_navigation();
    // force recalculation of loader position
    document.getElementById("loader").getBoundingClientRect();

    // pick a site from sites.txt
    let site = get_random_site(sites);
    // display site domain in #domain
    document.getElementById("domain").innerHTML = site;
    // set css classes and button text
    document.getElementById("button_text").innerHTML = "move to stop";
    document.getElementById("button").classList.add("stop");
    document.getElementById("loader").classList.add("loading");

    // start 3s timer to navigate to site
    timeoutId = setTimeout(function () { navigate_to_site(site) }, 3000);
    // toggle event listeners
    document.getElementById("button").addEventListener("mouseout", stop_navigation);
}

get_sites().then(sitesArray => {
    const sites = sitesArray;
    document.getElementById("button").classList.remove("loading");
    document.getElementById("button_text").innerHTML = "surf's up!";
    document.getElementById("button").addEventListener("click", function start() { initiate_navigation(sites) });
})