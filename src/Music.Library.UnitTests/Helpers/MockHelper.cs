using MediatR;
using Moq;
using Music.Library.Application.Features.DashBoard;
using Music.Library.Application.Features.Search;

namespace Music.Library.UnitTests.Helpers
{
    public static class MockHelper
    {
        public static Mock<IMediator> CreateSearchMediator(GetSearchResponse response)
        {
            var fakeMediator = new Mock<IMediator>(MockBehavior.Strict);
            fakeMediator.Setup(mediator => mediator.Send(It.IsAny<GetSearchRequest>(), default))
                .ReturnsAsync(response);

            return fakeMediator;
        }

        public static Mock<IMediator> CreateDashboardMediator(GetDashBoardResponse response)
        {
            var fakeMediator = new Mock<IMediator>(MockBehavior.Strict);
            fakeMediator.Setup(mediator => mediator.Send(It.IsAny<GetDashBoardRequest>(), default))
                .ReturnsAsync(response);

            return fakeMediator;
        }
    }
}
