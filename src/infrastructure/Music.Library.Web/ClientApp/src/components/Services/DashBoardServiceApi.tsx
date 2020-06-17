export default (function() {
    const fetchData = async () => {
        return await fetch("http://localhost:5000/api/dashboard/")
            .then(response => {
                if(!response.ok) {
                    throw Error(response.statusText);
                }
                return response.json()
            })
            .catch(error => console.log(error));
    } 

    return {
        fetchData: fetchData
    }
})();