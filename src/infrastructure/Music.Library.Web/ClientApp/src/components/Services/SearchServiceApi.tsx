export default (function() {
    const fetchSearchData = async (searchQuery: string, pageNumber: number, itemsPerPage: number) => {
        return await fetch(`http://localhost:5000/api/search/${searchQuery}/${pageNumber}/${itemsPerPage}`)
            .then(response => {
    
                if(!response.ok) {
                    throw Error(response.statusText);
                }
                return response.json()
            })
            .catch(error => console.log(error));
    }

    return {
        fetchSearchResults: fetchSearchData
    }
})();