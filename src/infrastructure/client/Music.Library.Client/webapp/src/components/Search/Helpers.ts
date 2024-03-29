/**
 * Get search results from api service.
 * @param {string} query The user supplied search query.
 */
export default (function Helpers() {

    const server = 'http://localhost:5000';
    const fetchSearchData = async (searchQuery: string, pageNumber: number, itemsPerPage: number) =>
        await fetch(`${server}/api/search/${searchQuery}/${pageNumber}/${itemsPerPage}`)
        .then(response => response.json())
        .then(data => data);

    const fetchInitialLoadData = async () =>
         await fetch(`${server}/api/dashboard/`)
            .then(response => response.json())
            .then(data => data);

    return {
        fetchSearchData: fetchSearchData,
        fetchInitialLoadData: fetchInitialLoadData
    }
})();