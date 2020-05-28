export default (function SearchAPI() {
    const fetchSearchData = async (searchQuery: string, pageNumber: number, itemsPerPage: number) => {
        const result = await fetch(`http://localhost:5000/api/search/${searchQuery}/${pageNumber}/${itemsPerPage}`)
            .then(response => {
    
                if(!response.ok) {
                    throw Error(response.statusText);
                }
                return response.json()
            })
            .catch(error => console.log(error));

            return result;
    }

    return {
        fetchSearchResults: fetchSearchData
    }
})();