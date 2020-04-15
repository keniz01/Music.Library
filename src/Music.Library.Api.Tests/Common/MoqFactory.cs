using MediatR;
using Moq;
using Music.Library.Application.UseCases.DashBoard;
using Music.Library.Application.UseCases.Search;
using Music.Library.Core.Entities;

namespace Music.Library.Api.Tests.Common
{
    public static class MoqFactory
    {
        public static Mock<IMediator> MockSearchMediator(SearchPackage response)
        {
            if(response is null)
            {
                throw new System.ArgumentNullException(nameof(response));
            }

            var fakeMediator = new Mock<IMediator>(MockBehavior.Strict);
            fakeMediator.Setup(mediator => mediator.Send(It.IsAny<GetSearchRequest>(), default))
                .ReturnsAsync(response);

            return fakeMediator;
        }

        public static Mock<IMediator> MockDashboardMediator(DashBoardPackage response)
        {
            var fakeMediator = new Mock<IMediator>(MockBehavior.Strict);
            fakeMediator.Setup(mediator => mediator.Send(It.IsAny<GetDashBoardRequest>(), default))
                .ReturnsAsync(response);

            return fakeMediator;
        }
    }
}
