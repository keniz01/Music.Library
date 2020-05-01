/**
 * Get search results from api service.
 * @param {string} query The user supplied search query.
 */
export default (function Helpers() {
    var local = "http://localhost:5000/";
    //var remote = "http://localhost/music.library.api/";

    const fetchSearchData = async (searchQuery: string, pageNumber: number, itemsPerPage: number) =>
        await fetch(`${local}api/search/${searchQuery}/${pageNumber}/${itemsPerPage}`)
        .then(response => response.json())
        .then(data => data);

    const fetchInitialLoadData = async () =>
         await fetch(`${local}api/dashboard/`)
            .then(response => response.json())
            .then(data => data);

    return {
        fetchSearchData: fetchSearchData,
        fetchInitialLoadData: fetchInitialLoadData
    }
})();